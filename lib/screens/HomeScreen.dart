import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  const Text(
                    'Seja bem vindo, Lucas',
                    style: TextStyle(
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
              const OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFFED008C))
                  ),
                  child: Text('Iniciar Desafio', style: TextStyle(color: Colors.white),),
                  )
            ],
          ),
        )
      ],
    ));
  }
}
