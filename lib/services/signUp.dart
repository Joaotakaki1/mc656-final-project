import 'dart:convert';
import 'dart:io';
import 'password_service.dart';
import 'username_check.dart';

class SignUp {
  static Future<bool> register(String username, String password) async {
    // Checagem da senha fornecida
    if (!PasswordService.isStrongPassword(password)) {
      print('Senha não é forte o suficiente.');
      return false;
    }

    // Checagem da disponibilidade do username
    if (UsernameCheck.isSignedUp(username)) {
      print('$username ja está em uso.');
      return false;
    }

    // Adicionar o usuário ao banco de dados (users.json)
    final file = File('users.json');
    List<dynamic> users = [];

    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      users = jsonDecode(jsonString);
    }

    users.add({'username': username, 'password': password});
    file.writeAsStringSync(jsonEncode(users));

    print('Cadastro realizado com sucesso.');
    return true;
  }
}