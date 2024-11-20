import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mc656finalproject/models/desafio.dart';

class MasterController {

  // fazer função para pegar o query e o documentsnapshot, ta usando em todas

  static Future<DocumentSnapshot> fetchUserDataBase(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference userDoc = firestore.collection('users').doc(uid);
    DocumentSnapshot userSnapshot = await userDoc.get();
    return userSnapshot;
  } 

  static Future<CollectionReference> fetchDesafioDataBase() async {
    FirebaseFirestore firestroe = FirebaseFirestore.instance;
    CollectionReference desafiosCollection = firestroe.collection('desafios');
    return desafiosCollection;
  }

  static Future<List<Desafio>> fetchDesafioTema(String tema) async {
    CollectionReference desafiosCollection = await fetchDesafioDataBase();

    // Aplicar filtro para selecionar documentos onde o identificador é igual ao valor do parâmetro 'tema'
    DocumentSnapshot docSnapshot = await desafiosCollection.doc(tema).get();

    // Converter o documento retornado em uma lista de objetos Desafio
    List<Desafio> desafios = [];
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        // Acessar a lista de strings
        List<dynamic> listaDeStrings = data['desafios'] as List<dynamic>;
        for (var item in listaDeStrings) {
          desafios.add(Desafio(desafio: item, tema: tema));
        }
      }
    }

    return desafios;
  }

  static Future<List<String>> fetchUserPreferences(String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    List<String> preferences = [];
    if (user.exists) {
      preferences = List<String>.from(user['preferences']);
    }
    return preferences;
  }

  static Future<List<int>> fetchUserStreak(String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    List<int> streak = [];
    if (user.exists) {
      streak.add(user['maxStreak']);
      streak.add(user['currentStreak']);
    }
    return streak;
  }

  static Future<void> updateUserPreferences(List<String> preferences, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userRef = user.reference;
      await userRef.update({'preferences': preferences});
    }
  }

  static Future<void> updateUserStreak(int maxStreak, int currentStreak, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userDoc = user.reference;
      await userDoc.update({'maxStreak': maxStreak, 'currentStreak': currentStreak});
    }
  }
}