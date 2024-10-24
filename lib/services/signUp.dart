import 'dart:convert';
import 'password_service.dart';
import 'username_check.dart';

class SignUp {
  static Future<String> register(
      String username, String password, String data) async {
    // Checagem da senha fornecida
    if (!PasswordService.isStrongPassword(password)) {
      print('Senha não é forte o suficiente.');
      return data;
    }

    // Checagem da disponibilidade do username
    if (UsernameCheck.isSignedUp(username)) {
      print('$username já está em uso.');
      return data;
    }

    // Adicionar o usuário ao banco de dados (users.json)
    List<dynamic> userMap = jsonDecode(data);

    userMap.add({'username': username, 'password': password});
    String updatedData = jsonEncode(userMap);
    return updatedData;
  }
}
