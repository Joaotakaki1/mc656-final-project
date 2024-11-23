import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/screens/preference_screen.dart';
import 'package:mc656finalproject/services/master_controller.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      var userSnapshot = await MasterController.fetchUserDataBase(widget.currentUser.uid);
      if (userSnapshot.exists) {
        var aux = userSnapshot.data() as Map<String, dynamic>?;
        setState(() {
          userData = aux;
        });
        if (aux?['hasSetPreferences'] == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreferenceScreen(currentUser: widget.currentUser),
            ),
          );
        }
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
                              'Você está a ${userData?['currentStreak'] ?? '0'} dias transbordando!',
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
                              'Sua melhor sequencia foi ${userData?['maxStreak'] ?? '0'}  dias',
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
              OutlinedButton(
                onPressed: () async {
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFFED008C))),
                child: const Text(
                  'Iniciar Desafio',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
