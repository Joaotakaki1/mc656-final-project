import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:mc656finalproject/models/user.dart';
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
      var userSnapshot = await MasterController.fetchUserDataBaseUser(widget.currentUser.uid);
      if (userSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>?;
        });
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
                    'Seja bem vindo ' + (userData?['email'] ?? ''),
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
                            const Text(
                              'Você está a 17 dias transbordando!',
                              style: TextStyle(
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
                            const Text(
                              'Sua melhor sequencia foi 28 dias',
                              style: TextStyle(
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
                  var collection = await MasterController.fetchUserDataBase();
                  collection.get().then((querySnapshot) {
                    for (var doc in querySnapshot.docs) {
                      print('Document ID: ${doc.id}');
                      print('Data: ${doc.data()}');
                    }
                  }).catchError((error) {
                    print('Erro ao obter documentos: $error');
                  });
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
