import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/preferences.dart';

class DataBaseController {
  static FirebaseAuth fetchFireBaseAuth() {
    return FirebaseAuth.instance;
  }

  static Future<CollectionReference> fetchUserCollection() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userCollection = firestore.collection('users');
    return userCollection;
  }

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



  static Future<List<String>> fetchUserPreferences(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot userDoc = await firestore.collection('users').doc(email).get();
    if (userDoc.exists) {
      List<String> preferences = List<String>.from(userDoc['preferences']);
      return preferences;
    } else {
      return [];
    }
  }

  static Future<Map<String, int>> fetchUserStreak(String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    Map<String, int> streak = {};
    if (user.exists) {
      streak['maxStreak'] = user['maxStreak'];
      streak['currentStreak'] = user['currentStreak'];
    }
    return streak;
  }

  static List<String> turnODSIconInString(List<OdsIcon> odsIcons) {
    List<String> preferences = odsIcons.map((odsIcon) => odsIcon.ods).toList();
    return preferences;
  }

  static List<String> turnPreferencesInString(Preferences preferenceClass){
    List<String> preferences = preferenceClass.preferences;
    return preferences;
  }

  static Future<void> updateUserPreferences(List<String> preferences, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userRef = user.reference;
      await userRef.update({'preferences': preferences, 'hasSetPreferences': true});
    }
  }

  static Future<void> updateUserMaxStreak(int maxStreak, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userDoc = user.reference;
      await userDoc.update({'maxStreak': maxStreak});
    }
  }

  static Future<void> updateUserCurrentStreak(int currentStreak, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userDoc = user.reference;
      await userDoc.update({'currentStreak': currentStreak});
    }
  }

  static Future<UserCredential?> registerWithEmailPassword(String email, String password, String username) async {
    FirebaseAuth auth = fetchFireBaseAuth();
    CollectionReference firestore = await fetchUserCollection();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.doc(userCredential.user?.uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'hasSetPreferences': false,
      });
      print('Cadastro realizado com sucesso: ${userCredential.user?.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        print('A conta já existe para esse email.');
      } else {
        print('Erro ao cadastrar usuário: $e');
      }
      return null;
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }
}