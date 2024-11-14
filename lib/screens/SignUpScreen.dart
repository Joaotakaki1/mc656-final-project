import 'package:flutter/material.dart';
import 'package:mc656finalproject/screens/HomeScreen.dart';
import 'package:mc656finalproject/services/login_verify.dart';
import 'package:mc656finalproject/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  // Controladores para capturar o texto dos campos de usuário e senha
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Função de login
  Future<bool> _signUp() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            width: double.infinity, // Define a largura para ocupar toda a tela
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fitWidth, // Ajusta a imagem para a largura da tela, mantendo a proporção
                alignment: Alignment.bottomCenter, // Alinha a imagem no topo
              ),
            ),
          ),
          // Conteúdo da tela
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png', // Coloque o caminho para a logo
                    width: 250, // Ajuste o tamanho da logo
                    height: 250,
                  ),

                  const SizedBox(height: 24.0),
                  // Campo de usuário
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Campo de senha
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirme a senha',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkPink, width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16.0),

                  // Botão de Cadastro
                  OutlinedButton(
                    onPressed: () {
                      // Ação de cadastro
                      print("Volta para a tela de login");
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white, // Cor do texto do botão
                      side: const BorderSide(color: darkPink, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: darkPink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}