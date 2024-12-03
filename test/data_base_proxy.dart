import 'package:mc656finalproject/services/data_base_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/desafio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc656finalproject/models/preferences.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
class DataBaseProxy {
  final FirebaseFirestore firestore;

  DataBaseProxy({required this.firestore});


  FirebaseAuth fetchFireBaseAuth() {
    return DataBaseController.fetchFireBaseAuth();
  }

  Future<CollectionReference> fetchUserCollection() async {
    return await DataBaseController.fetchUserCollection();
  }

  Future<DocumentSnapshot> fetchUserDataBase(String uid) async {
    return await DataBaseController.fetchUserDataBase(uid);
  }

  Future<CollectionReference> fetchDesafioDataBase() async {
    return await DataBaseController.fetchDesafioDataBase();
  }

  Future<List<Desafio>> fetchDesafioTema(String tema) async {
    return await DataBaseController.fetchDesafioTema(tema);
  }

  Future<CollectionReference> fetchChallengeDataBase() async {
    return await DataBaseController.fetchChallengeDataBase();
  }

  Future<List<Desafio>> fetchChallengeTema(String tema) async {
    return await DataBaseController.fetchChallengeTema(tema);
  }

  Future<String> fetchUserLastLogin(String? uid) async {
    return await DataBaseController.fetchUserLastLogin(uid);
  }

  Future<void> updateUserLastLogin(String? uid) async {
    return await DataBaseController.updateUserLastLogin(uid);
  }

  Future<String> fetchUserCurrentLogin(String? uid) async {
    return await DataBaseController.fetchUserCurrentLogin(uid);
  }

  Future<void> updateUserCurrentLogin(String? uid) async {
    return await DataBaseController.updateUserCurrentLogin(uid);
  }

  Future<List<String>> fetchUserPreferences(String uid) async {
    return await DataBaseController.fetchUserPreferences(uid);
  }

  Future<Map<String, int>> fetchUserStreak(String uid) async {
    return await DataBaseController.fetchUserStreak(uid);
  }

  Future<int> fetchUserCoposSalvos(String uid) async {
    return await DataBaseController.fetchUserCoposSalvos(uid);
  }

  Future<int> fetchUserPessoasImpactadas(String uid) async {
    return await DataBaseController.fetchUserPessoasImpactadas(uid);
  }

  List<String> turnODSIconInString(List<OdsIcon> odsIcons) {
    return DataBaseController.turnODSIconInString(odsIcons);
  }

  List<String> turnPreferencesInString(Preferences preferenceClass) {
    return DataBaseController.turnPreferencesInString(preferenceClass);
  }

  Future<void> updateUserPreferences(List<String> preferences, String uid) async {
    return await DataBaseController.updateUserPreferences(preferences, uid);
  }

  Future<void> updateUserMaxStreak(int maxStreak, String uid) async {
    return await DataBaseController.updateUserMaxStreak(maxStreak, uid);
  }

  Future<void> updateUserCurrentStreak(int currentStreak, String uid) async {
    return await DataBaseController.updateUserCurrentStreak(currentStreak, uid);
  }

  Future<void> updateUserCoposSalvos(int coposSalvos, String uid) async {
    return await DataBaseController.updateUserCoposSalvos(coposSalvos, uid);
  }

  Future<void> updateUserPessoasImpactadas(int pessoasImpactadas, String uid) async {
    return await DataBaseController.updateUserPessoasImpactadas(pessoasImpactadas, uid);
  }

  Future<bool> fetchCompletedChallenges(String uid) async {
    return await DataBaseController.fetchCompletedChallenges(uid);
  }

  Future<void> updateCompletedChallenges(String uid, bool concluiu) async {
    return await DataBaseController.updateCompletedChallenges(uid, concluiu);
  }

  Future<UserCredential?> registerWithEmailPassword(String email, String password, String username) async {
    return await DataBaseController.registerWithEmailPassword(email, password, username);
  }

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    return await DataBaseController.sendPasswordResetEmail(context, email);
  }

}