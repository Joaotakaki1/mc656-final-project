import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc656finalproject/services/master_controller.dart';
import 'package:mc656finalproject/services/password_service.dart';
import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart' as UserClass;
import 'package:mc656finalproject/screens/home_screen.dart';

class SignUpController {

  static void signUpNotice(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  static void goToHome(BuildContext context, var currentUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                currentUser: currentUser,
              )),
    );
  }

  static void signUpCheck(String password, String confirmPassword, String username, String email, BuildContext context) async {
    if (password == confirmPassword) {
      if (PasswordService.isStrongPassword(password)) {
        UserCredential? success = await MasterController.registerWithEmailPassword(
          email,
          password,
          username,
        );
        if (success != null) {
          signUpNotice(context, 'Cadastro realizado com sucesso.');
          var currentUser = UserClass.User(
              email: success.user?.email ?? '',
              uid: success.user?.uid ?? '',
              username: success.user?.email ?? '');
          goToHome(context, currentUser);
        } else {
          signUpNotice(context, 'Erro ao cadastrar, tente novamente');
        }
      } else {
        signUpNotice(context, 'Senha fraca, tente novamente.');
      }
    } else {
      signUpNotice(context, 'As senhas devem ser iguais, tente novamente.');
    }
  }
}