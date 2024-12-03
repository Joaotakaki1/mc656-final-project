import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart' as UserClass;
import 'package:mc656finalproject/screens/home_screen.dart';
import 'package:mc656finalproject/components/app_text_field.dart';
import 'package:mc656finalproject/services/password_service.dart';
import 'package:mc656finalproject/services/signUp_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  void _showPasswordRequirements(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Requisitos da Senha'),
          content: const Text(
            'A senha deve ter:\n'
            '- No mínimo 8 caracteres;\n'
            '- Ao menos 1 letra;\n'
            '- Ao menos 1 número;\n'
            '- Ao menos 1 caracter especial (por exemplo, .-@!?*#)',
            style: TextStyle(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 24.0),
                  AppTextField(
                    controller: _usernameController,
                    text: 'Usuário',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  AppTextField(
                    controller: _emailController,
                    text: 'Email',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  // Campo de senha com botão de ajuda
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      AppTextField(
                        controller: _passwordController,
                        text: 'Senha',
                        vPadding: 10.0,
                        hPadding: 20.0,
                        bRadius: 30.0,
                        password: true,
                      ),
                      IconButton(
                        onPressed: () => _showPasswordRequirements(context),
                        icon: const Icon(
                          Icons.help_outline,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  AppTextField(
                    controller: _confirmPasswordController,
                    text: 'Confirme a senha',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: true,
                  ),
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      SignUpController.signUpCheck(
                        _passwordController.text,
                        _confirmPasswordController.text,
                        _usernameController.text,
                        _emailController.text,
                        context,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: darkPink, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: darkPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: darkPink, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        color: darkPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
