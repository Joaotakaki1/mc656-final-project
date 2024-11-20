import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'password_service.dart';
import 'username_check.dart';

class SignUp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<bool> register(String username, String password) async {
    // Checagem da senha fornecida
    if (!PasswordService.isStrongPassword(password)) {
      print('Senha não é forte o suficiente.');
      return false;
    }

    // Checagem da disponibilidade do username
    if (UsernameCheck.isSignedUp(username)) {
      print('$username ja está em uso.');
      return false;
    }

    // Adicionar o usuário ao banco de dados (users.json)
    final file = File('assets/users.json');
    List<dynamic> users = [];

    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      users = jsonDecode(jsonString);
    }

    users.add({'username': username, 'password': password});
    file.writeAsStringSync(jsonEncode(users));

    print('Cadastro realizado com sucesso.');
    return true;
  }

  Future<UserCredential?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
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