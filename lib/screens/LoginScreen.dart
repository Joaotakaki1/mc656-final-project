import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/screens/HomeScreen.dart';
import 'package:mc656finalproject/screens/SignUpScreen.dart';
import 'package:mc656finalproject/services/login_verify.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:mc656finalproject/components/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para capturar o texto dos campos de usuário e senha
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool isEmpty() {
    return (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty);
  }

  Future<dynamic> resultadoLogin() async {
    Map<String, dynamic> resultado = await LoginCheck.loginWithEmailPassword(
        _usernameController.text, _passwordController.text);
    return resultado;
  }

  Future<bool> _login() async {
    setState(() {
      _isLoading = true;
    });
    // Lógica para autenticação
    if (isEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos")),
      );
      setState(() {
        _isLoading = false;
      });
      return false;
    }
    var res = await resultadoLogin();
    if (!res['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['message'])),
      );
      setState(() {
        _isLoading = false;
      });
      return false;
    }
    var currentUser = User(email: res['user'].email, uid: res['user'].uid, username: res['user'].email);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(currentUser: currentUser, )),
    );

    setState(() {
      _isLoading = false;
    });

    return true;
  }

  void _signUp() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _forgotPassword() {
    print("Forgot my password not developed yet");
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
                fit: BoxFit
                    .fitWidth, // Ajusta a imagem para a largura da tela, mantendo a proporção
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
                  AppTextField(
                    controller: _usernameController,
                    text: 'Email',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: false,
                  ),
                  const SizedBox(height: 16.0),
                  // Campo de senha
                  AppTextField(
                    controller: _passwordController,
                    text: 'Senha',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: true,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botão Entrar alinhado à esquerda
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkPink,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: darkPink, width: 2.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Texto "Esqueci minha senha" alinhado à direita
                      GestureDetector(
                        onTap: _forgotPassword,
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: lightPink,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Botão de Cadastro
                  OutlinedButton(
                    onPressed: () {
                      // Ação de cadastro
                      _signUp();
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
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFED008C),),
              ),
            ),
        ],
      ),
    );
  }
}
