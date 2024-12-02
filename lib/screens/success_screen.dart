import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mc656finalproject/utils/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: lightPink,
      appBar: AppBar(
        backgroundColor: lightPink,
        leading: IconButton(
          icon: Image.asset('assets/icons/return.png'),
          onPressed: () {
            Navigator.of(context).pop();
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
