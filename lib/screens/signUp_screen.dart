import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart' as UserClass;
import 'package:mc656finalproject/screens/home_screen.dart';
import 'package:mc656finalproject/components/app_text_field.dart';
import 'package:mc656finalproject/services/password_service.dart';
import 'package:mc656finalproject/services/signUp.dart';
import 'package:mc656finalproject/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  // Controladores para capturar o texto dos campos de usuário e senha
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false; // Variável para controlar a visibilidade do indicador de progresso

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
                  AppTextField(
                    controller: _confirmPasswordController,
                    text: 'Confirme a senha',
                    vPadding: 10.0,
                    hPadding: 20.0,
                    bRadius: 30.0,
                    password: true,
                  ),
                  const SizedBox(height: 16.0),
                  // Botão de Cadastro
                  OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // Mostrar o indicador de progresso
                      });

                      if (_passwordController.text == _confirmPasswordController.text) {
                        if (PasswordService.isStrongPassword(_passwordController.text)) {
                          SignUp signUp = SignUp();
                          UserCredential? success = await signUp.registerWithEmailPassword(
                              _emailController.text,
                              _passwordController.text, 
                              _usernameController.text,);
                          if (success != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Cadastro Realizado com sucesso'),
                            ));
                            var currentUser = UserClass.User(email: success.user?.email ?? '', uid: success.user?.uid ?? '', username: success.user?.email ?? '');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(currentUser: currentUser,)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Erro ao cadastrar, tente novamente'),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Senha fraca, tente novamente'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'As senhas devem ser iguais, tente novamente'),
                        ));
                      }

                      setState(() {
                        _isLoading = false; // Ocultar o indicador de progresso
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white, // Cor do texto do botão
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
          // Indicador de progresso
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5), // Fundo escuro com opacidade
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}