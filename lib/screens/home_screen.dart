import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/screens/preference_screen.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';

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
  ChallengeController challengeController = ChallengeController([]);
  Map<Desafio, bool> challengeCompletionStatus = {};

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      // Fetch user data
      var userSnapshot = await DataBaseController.fetchUserDataBase(widget.currentUser.uid);
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
              builder: (context) => PreferenceScreen(currentUser: widget.currentUser),
            ),
          );
        }

      // Fetch user preferences
      var preferences = await DataBaseController.fetchUserPreferences(widget.currentUser.uid);
      setState(() {
        userPreferences = preferences;
      });
      challengeController.setPreferences(preferences);

      // Fetch user streak
      var streak = await DataBaseController.fetchUserStreak(widget.currentUser.uid);
      setState(() {
        userStreak = streak;
      });
        if (aux?['hasSetPreferences'] == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreferenceScreen(currentUser: widget.currentUser),
            ),
          );
        }
    } catch (error) {
      print('Erro ao obter documentos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Image.asset('assets/icons/config.png'),
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
                current_challenges.isNotEmpty
                    ? Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: current_challenges.isNotEmpty
                                  ? Border.all(width: 2.0, color: lightPink)
                                  : Border.all(width: 0, color: lightPink),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: current_challenges.map((desafio) {
                                return CheckboxListTile(
                                  title: Text(desafio.desafio),
                                  value: challengeCompletionStatus[desafio] ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      challengeCompletionStatus[desafio] = value ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity.leading, // Checkbox à esquerda
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    // Adicione a lógica para iniciar o desafio aqui
                    if (challengeController.possibleChallenges.isNotEmpty) {
                      challengeController.randomizeChallenges();
                      setState(() {
                        current_challenges = challengeController.currentChallenges;
                        challengeCompletionStatus = {for (var desafio in current_challenges) desafio: false};
                      });
                      print(challengeController.currentChallenges);
                    } else {
                      print('Nenhum desafio disponível.');
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