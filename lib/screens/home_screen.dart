import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/screens/config_screen.dart';
import 'package:mc656finalproject/screens/daily_progress_screen.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/screens/preference_screen.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData;
  List<String>? userPreferences;
  Map<String, int>? userStreak;
  List<Desafio> current_challenges = [];
  Map<Desafio, bool> challengeCompletionStatus = {};

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      final challengeController =
          Provider.of<ChallengeController>(context, listen: false);
      // Fetch user data
      var userSnapshot =
          await DataBaseController.fetchUserDataBase(widget.currentUser.uid);
      Map<String, dynamic>? aux;
      if (userSnapshot.exists) {
        aux = userSnapshot.data() as Map<String, dynamic>?;
        setState(() {
          userData = aux;
        });
      }
      if (aux?['hasSetPreferences'] == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreferenceScreen(currentUser: widget.currentUser),
          ),
        );
      }

      // Fetch user preferences
      var preferences =
          await DataBaseController.fetchUserPreferences(widget.currentUser.uid);
      setState(() {
        userPreferences = preferences;
      });
      challengeController.setPreferences(preferences);

      // Fetch user streak
      var streak =
          await DataBaseController.fetchUserStreak(widget.currentUser.uid);
      setState(() {
        userStreak = streak;
      });
      if (aux?['hasSetPreferences'] == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PreferenceScreen(currentUser: widget.currentUser),
          ),
        );
      }
    } catch (error) {
      print('Erro ao obter documentos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final challengeController =
        Provider.of<ChallengeController>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/decorationUpper.png',
            fit: BoxFit.fill,
            width: double.maxFinite,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seja bem vindo, ' + (userData?['username'] ?? ''),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(254, 242, 0, 1)),
                    ),
                    GestureDetector(
                      child: Image.asset('assets/icons/config.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfigScreen(
                              currentUser: widget.currentUser,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 40),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.red, Colors.green]),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/stair.png',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Você está a ${userStreak?['currentStreak'] ?? '0'} dias transbordando!',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/trophy.png',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sua melhor sequencia foi ${userStreak?['maxStreak'] ?? '0'}  dias',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // Adicionar a coluna com os desafios atuais
                (challengeController.completedChallenges.isNotEmpty)
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset('assets/icons/cup.png'),
                            const SizedBox(height: 20),
                            const Text(
                              "Bom trabalho!",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: darkPink,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Volte amanhã para mais desafios",
                              style: TextStyle(fontSize: 20, color: darkPink),
                            ),
                          ],
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          final challengeController =
                              Provider.of<ChallengeController>(context,
                                  listen: false);
                          // Adicione a lógica para iniciar o desafio aqui
                          if (challengeController
                                  .possibleChallenges.isNotEmpty &&
                              challengeController.currentChallenges.isEmpty) {
                            challengeController.randomizeChallenges();
                            setState(() {
                              current_challenges =
                                  challengeController.currentChallenges;
                              challengeCompletionStatus = {
                                for (var desafio in current_challenges)
                                  desafio: false
                              };
                            });
                          }
                          if (challengeController
                              .currentChallenges.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DailyProgressScreen(
                                  desafios: current_challenges,
                                  currentUser: widget.currentUser,
                                ),
                              ),
                            );
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(darkPink)),
                        child: const Text(
                          'Iniciar Desafio',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
