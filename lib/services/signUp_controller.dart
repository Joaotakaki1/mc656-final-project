import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // void signUpCheck(String password, String confirmPassword, String username) async {
  //   if (password == confirmPassword) {
  //     if (PasswordService.isStrongPassword(password)) {
  //       SignUpController signUp = SignUpController();
  //       UserCredential? success = await signUp.registerWithEmailPassword(
  //           _usernameController,
  //           password, _usernameController,);
  //       if (success != null) {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(const SnackBar(
  //           content: Text('Cadastro Realizado com sucesso'),
  //         ));
  //         var currentUser = UserClass.User(email: success.user?.email ?? '', uid: success.user?.uid ?? '', username: success.user?.email ?? '');
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => HomeScreen(currentUser: currentUser,)),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text('Erro ao cadastrar, tente novamente'),
  //         ));
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Senha fraca, tente novamente'),
  //       ));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(
  //       content: Text(
  //           'As senhas devem ser iguais, tente novamente'),
  //     ));
  //   }
  // }

  Future<UserCredential?> registerWithEmailPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'username': username,
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