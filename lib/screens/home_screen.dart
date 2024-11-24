import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:mc656finalproject/services/master_controller.dart';
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
      var userSnapshot = await MasterController.fetchUserDataBase(widget.currentUser.uid);
      if (userSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>?;
        });
      }

      // Fetch user preferences
      var preferences = await MasterController.fetchUserPreferences(widget.currentUser.uid);
      setState(() {
        userPreferences = preferences;
      });
      challengeController.setPreferences(preferences);

      // Fetch user streak
      var streak = await MasterController.fetchUserStreak(widget.currentUser.uid);
      setState(() {
        userStreak = streak;
      });

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
                                  ? Border.all(width: 2.0, color: darkPink)
                                  : Border.all(width: 0, color: darkPink),
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
                    if (challengeController.possible_challenges.isNotEmpty) {
                      challengeController.randomize_challenges();
                      setState(() {
                        current_challenges = challengeController.current_challenges;
                        challengeCompletionStatus = {for (var desafio in current_challenges) desafio: false};
                      });
                      print(challengeController.current_challenges);
                    } else {
                      print('Nenhum desafio disponível.');
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFFED008C))),
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