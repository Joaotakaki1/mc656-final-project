import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

/// Controlador responsável pela lógica de gamificação.
class GamificationController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User user;

  /// Construtor que recebe a instância do usuário.
  GamificationController(this.user);

  /// Retorna a sequência atual do usuário, buscando do Firestore.
  Future<int> getCurrentStreak() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.email).get();
      if (userDoc.exists) {
        return userDoc['currentStreak'] ?? 0;
      } else {
        print('Documento do usuário não encontrado.');
        return 0;
      }
    } catch (e) {
      print('Erro ao buscar currentStreak: $e');
      return 0;
    }
  }

  /// Retorna a maior sequência alcançada pelo usuário, buscando do Firestore.
  Future<int> getMaxStreak() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.email).get();
      if (userDoc.exists) {
        return userDoc['maxStreak'] ?? 0;
      } else {
        print('Documento do usuário não encontrado.');
        return 0;
      }
    } catch (e) {
      print('Erro ao buscar maxStreak: $e');
      return 0;
    }
  }

  /// Retorna a quantidade de desafios completados pelo usuário.
  int getCompletedChallengesCount() {
    return user.preferences.completed_challenges.length;
  }
}
