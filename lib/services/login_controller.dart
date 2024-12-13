import 'package:firebase_auth/firebase_auth.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
import 'package:mc656finalproject/services/gamification_controller.dart';

class LoginController {
  LoginController();

  static Future<Map<String, dynamic>> loginWithEmailPassword(String email, String password, {FirebaseAuth? mock}) async {
    try {
      UserCredential userCredential = (mock != null)
      ? await mock.signInWithEmailAndPassword(
        email: email,
        password: password,
      )
      : await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      // Guardar a data do login no banco de dados
      await DataBaseController.updateUserLastLogin(userCredential.user?.uid);
      await DataBaseController.updateUserCurrentLogin(userCredential.user?.uid);
      final current = await DataBaseController.fetchUserCurrentLogin(userCredential.user?.uid);
      final last = await DataBaseController.fetchUserLastLogin(userCredential.user?.uid);
      if (current != last) {
        bool concluiu = await DataBaseController.fetchCompletedChallenges((userCredential.user?.uid)!);
        if (!concluiu) {
          GamificationController.milestoneStreak(concluiu, (userCredential.user?.uid)!);
        }
        await DataBaseController.updateCompletedChallenges((userCredential.user?.uid)!, false);
      }

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
          'message': 'Email ou senha incorretos, tente novamente'
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