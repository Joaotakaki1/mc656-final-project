import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> LoginVerify(String username, String password) async {
  // Caminho do arquivo JSON
  const String filePath = 'assets/users.json';

  // Lê o arquivo JSON
  final String jsonString = await File(filePath).readAsString();
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
          'message': 'senha incorreta'
        };
      }
    }
  }

  // Se o username não for encontrado
  return {
    'success': false,
    'message': 'esse usuário não existe'
  };
}