import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginCheck {
  static Future<Map<String, dynamic>> _dataBaseFetch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('users');
    QuerySnapshot querySnapshot = await usersCollection.get();
    Map<String, dynamic> users = {};
    for (var doc in querySnapshot.docs) {
      users[doc.id] = doc.data();
    }
    return users;
  }

  static Future<Map<String, dynamic>> loginVerify(String username, String password) async {

    Map<String, dynamic> users = await _dataBaseFetch();

    // Verifica se o username existe
    for (var user in users.values) {
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

  static Future<Map<String, dynamic>> loginWithEmailPassword(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {
        'success': true,
        'message': 'Login feito com sucesso',
        'user': userCredential.user
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {
          'success': false,
          'message': 'Usuário não cadastrado'
        };
      } else if (e.code == 'wrong-password') {
        return {
          'success': false,
          'message': 'Senha Incorreta'
        };
      } else {
        return {
          'success': false,
          'message': 'Erro ao fazer login: $e'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro inesperado: $e'
      };
    }
  }
}