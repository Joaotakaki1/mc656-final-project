import 'package:flutter/material.dart';
import 'package:mc656finalproject/screens/HomeScreen.dart';
import 'package:mc656finalproject/screens/SignUpScreen.dart';
import 'package:mc656finalproject/services/login_verify.dart';
import 'package:mc656finalproject/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para capturar o texto dos campos de usuário e senha
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função de login
  Future<bool> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Aqui você pode adicionar a lógica de autenticação
    if (username.isEmpty || password.isEmpty) {
      // Exemplo de lógica: mostrar um alerta se o usuário ou senha estiverem vazios
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos")),
      );
      return false;
    } 
    Map<String, dynamic> result = await LoginVerify(username, password);
    if (result['success'] == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        // puts the result['mesage
        SnackBar(content: Text(result['message'])),
      );
      return false;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

    return true;
  }


  void _signUp() async {
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os widgets para os cantos
                    children: [
                      // Botão Entrar alinhado à esquerda
                      ElevatedButton(
                        onPressed: _login, // Chama a função de login ao pressionar o botão
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkPink, // Cor do fundo do botão
                          foregroundColor: Colors.white, // Cor do texto do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: darkPink, width: 2.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
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
                        onTap: _forgotPassword, // Função para o esqueci minha senha
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: lightPink,
                            decoration: TextDecoration.underline, // Sublinhado no texto
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