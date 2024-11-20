import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mc656finalproject/models/desafio.dart';

class MasterController {

  // fazer função para pegar o query e o documentsnapshot, ta usando em todas

  static Future<CollectionReference> fetchUserDataBase() async {
    FirebaseFirestore firestroe = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestroe.collection('users');
    return usersCollection;
  }
  
  static Future<DocumentSnapshot> fetchUserDataBaseUser(String uid) async {
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

  static Future<List<String>> fetchUserPreferences(String email) async {
    CollectionReference users = await fetchUserDataBase();
    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    List<String> preferences = [];
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      preferences = List<String>.from(userDoc['preferences']);
    }
    return preferences;
  }

  static Future<List<int>> fetchUserStreak(String email) async {
    CollectionReference users = await fetchUserDataBase();
    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    List<int> streak = [];
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      streak.add(userDoc['maxStreak']);
      streak.add(userDoc['currentStreak']);
    }
    return streak;
  }

  static Future<void> updateUserPreferences(List<String> preferences, String email) async {
    CollectionReference users = await fetchUserDataBase();
    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference userDoc = querySnapshot.docs.first.reference;
      await userDoc.update({'preferences': preferences});
    }
  }

  static Future<void> updateUserStreak(int maxStreak, int currentStreak, String email) async {
    CollectionReference users = await fetchUserDataBase();
    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference userDoc = querySnapshot.docs.first.reference;
      await userDoc.update({'maxStreak': maxStreak, 'currentStreak': currentStreak});
    }
  }
}