import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return await userDoc.get();
  } 

  static Future<CollectionReference> fetchDesafioDataBase() async {
    FirebaseFirestore firestroe = FirebaseFirestore.instance;
    return firestroe.collection('desafios');
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
          desafios.add(Desafio(desafio: item, tema: tema, descricaoCurta: '', descricao: '', pessoasAfetadas: 0, coposPlasticos: 0, impactoQualitativo: []));
        }
      }
    }

    return desafios;
  }

  static Future<CollectionReference> fetchChallengeDataBase() async {
      FirebaseFirestore firestroe = FirebaseFirestore.instance;
      return firestroe.collection('desafios');
  }

  static Future<List<Desafio>> fetchChallengeTema(String tema) async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Buscar todos os documentos na coleção 'desafios'
    QuerySnapshot querySnapshot = await firestore
        .collection('challenges')
        .where('desafio.ods', isEqualTo: tema)
        .get();

    // Mapear os documentos retornados para objetos Desafio
    List<Desafio> desafios = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Desafio.fromFirestore(data['desafio']);
    }).toList();

    return desafios;
  }

  static Future<String> fetchUserLastLogin(String uid) async {
    DocumentSnapshot userDoc = await fetchUserDataBase(uid);
    if (userDoc.exists) {
      return userDoc['lastLogin'];
    } else { 
      return '';
    }
  }

  static Future<void> updateUserLastLogin(String? uid) async {
    DocumentSnapshot userDoc = await fetchUserDataBase(uid!);
    DocumentReference user = FirebaseFirestore.instance.collection('users').doc(uid);
    await user.update({'lastLogin': userDoc['currentLogin']});
  }

  static Future<String> fetchUserCurrentLogin(String uid) async {
    DocumentSnapshot userDoc = await fetchUserDataBase(uid);
    if (userDoc.exists) {
      return userDoc['currentLogin'];
    } else { 
      return '';
    }
  }

  static Future<void> updateUserCurrentLogin(String? uid) async {
    DocumentReference user = FirebaseFirestore.instance.collection('users').doc(uid);
    await user.update({'currentLogin': DateTime.now().toIso8601String().split('T')[0]});
  }

  static Future<List<String>> fetchUserPreferences(String email) async {
    DocumentSnapshot userDoc = await fetchUserDataBase(email);
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

  static Future<int> fetchUserCoposSalvos(String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      return user['coposSalvos'];
    } else {
      return 0;
    }
  }

  static Future<int> fetchUserPessoasImpactadas(String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      return user['pessoasImpactadas'];
    } else {
      return 0;
    }
  }

  static List<String> turnODSIconInString(List<OdsIcon> odsIcons) {
    return odsIcons.map((odsIcon) => odsIcon.ods).toList();
  }

  static List<String> turnPreferencesInString(Preferences preferenceClass){
    return preferenceClass.preferences;
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

  static Future<void> updateUserCoposSalvos(int coposSalvos, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userDoc = user.reference;
      await userDoc.update({'coposSalvos': coposSalvos});
    }
  }

  static Future<void> updateUserPessoasImpactadas(int pessoasImpactadas, String uid) async {
    DocumentSnapshot user = await fetchUserDataBase(uid);
    if (user.exists) {
      DocumentReference userDoc = user.reference;
      await userDoc.update({'pessoasImpactadas': pessoasImpactadas});
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
        'preferences': [],
        'maxStreak': 0,
        'currentStreak': 0,
        'coposSalvos': 0,
        'pessoasImpactadas': 0,
        'lastLogin': '',
        'currentLogin': DateTime.now().toIso8601String().split('T')[0]
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
  static Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    FirebaseAuth auth = fetchFireBaseAuth();
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email de redefinição de senha enviado para $email')),
      );
    } catch (e) {
      print('Erro ao enviar email de redefinição de senha: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar email de redefinição de senha: $e')),
      );
    }
  }
}