import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/screens/home_screen.dart';
import 'package:mc656finalproject/utils/colors.dart';

class SuccessScreen extends StatelessWidget {
  final User currentUser;
  const SuccessScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: lightPink,
      appBar: AppBar(
        backgroundColor: lightPink,
        leading: IconButton(
          icon: Image.asset('assets/icons/return.png'),
          onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(currentUser: currentUser,)),
          );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
