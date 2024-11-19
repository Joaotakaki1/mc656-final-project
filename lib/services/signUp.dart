import 'dart:convert';
import 'dart:io';
import 'password_service.dart';
import 'username_check.dart';
import 'package:path_provider/path_provider.dart';

class SignUp {

  static Future<Map<String, dynamic>> register(String username, String password) async {
    // Checagem da senha fornecida
    if (!PasswordService.isStrongPassword(password)) {
      return {
        'success': false,
        'message': 'Senha não é forte o suficiente.'
      };
    }

  if (await UsernameCheck.isSignedUp(username)) {
    return {
      'success': false,
      'message': 'Nome de usuário já está em uso.'
    };
  }

  // Obtém o diretório para armazenar arquivos
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/users.json';
  final file = File(filePath);

  List<dynamic> users = [];

  // Lê o arquivo JSON se ele existir
  if (await file.exists()) {
    final jsonString = await file.readAsString();
    users = jsonDecode(jsonString);
  }

  // Adiciona o novo usuário
  users.add({'username': username, 'password': password});

  // Escreve de volta no arquivo
  await file.writeAsString(jsonEncode(users));

  return {
    'success': true,
    'message': 'Cadastro realizado com sucesso.'
  };
}
}