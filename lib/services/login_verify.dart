import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> LoginVerify(String username, String password) async {
  // Caminho do arquivo JSON
  const String filePath = 'assets/users.json';

  // Lê o arquivo JSON usando rootBundle
  final String jsonString = await rootBundle.loadString(filePath);
  final List<dynamic> users = jsonDecode(jsonString);

  // Verifica se o username existe
  for (var user in users) {
    if (user['username'] == username) {
      // Verifica se a senha está correta
      if (user['password'] == password) {
        return {
          'success': true,
          'message': 'Login feito com sucesso'
        };
      } else {
        return {
          'success': false,
          'message': 'Senha Incorreta'
        };
      }
    }
  }

  // Se o username não for encontrado
  return {
    'success': false,
    'message': 'Usuário não cadastrado'
  };
}