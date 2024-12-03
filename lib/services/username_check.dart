import 'dart:convert';
import 'dart:io';

class UsernameCheck {
  static bool isSignedUp(String username) {
    // Leitura do arquivo json com os dados dos Usuários
    final file = File('assets/users.json');
    if (!file.existsSync()) {
      return false;
    }

    // Leitura e organização dos usernames
    final jsonString = file.readAsStringSync();
    final List<dynamic> users = jsonDecode(jsonString);

    // Checagem da presença do username no banco de dados (json)
    for (var user in users) {
      if (user['username'] == username) {
        return true;
      }
    }
    return false;
  }
}