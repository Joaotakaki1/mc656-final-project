import 'dart:convert';
import 'dart:io';

class JsonFileHandler {
  final String filePath;

  JsonFileHandler(this.filePath);

  Future<List<dynamic>> readJsonFile() async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      print('Erro ao ler o arquivo: $e');
      return [];
    }
  }

  Future<void> writeJsonFile(List<dynamic> data) async {
    try {
      final file = File(filePath);
      final jsonString = jsonEncode(data);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Erro ao escrever no arquivo: $e');
    }
  }
}
