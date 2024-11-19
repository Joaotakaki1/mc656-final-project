import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UsernameCheck {
  static Future<bool> isSignedUp(String username) async {
    // Obtém o diretório para armazenar arquivos
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/users.json';
    final file = File(filePath);

    // Verifica se o arquivo existe
    if (!await file.exists()) {
      return false; // Se o arquivo não existe, o usuário não está registrado
    }

    // Lê e decodifica o arquivo JSON
    final String jsonString = await file.readAsString();
    final List<dynamic> users = jsonDecode(jsonString);

    // Checagem da presença do username
    return users.any((user) => user['username'] == username);
  }
}
