import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/user_preferences_controller.dart';
import 'models/preferences.dart';
import 'services/master_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AlzaSyBHw_vEF92MZM12NVGLc-OmVx19B4BiVPE',
      appId: '1:309461612025:android:bb9469cac5443614843928',
      messagingSenderId: '309461612025',
      projectId: 'mc656-final-project',
    ),
  );

  runApp(const TestUserPreferencesApp());
}

class TestUserPreferencesApp extends StatelessWidget {
  const TestUserPreferencesApp({super.key}); // Usando "super.key" diretamente.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test User Preferences')),
        body: const TestUserPreferences(),
      ),
    );
  }
}

class TestUserPreferences extends StatefulWidget {
  const TestUserPreferences({super.key}); // Usando "super.key" diretamente.

  @override
  State<TestUserPreferences> createState() => _TestUserPreferencesState();
}

class _TestUserPreferencesState extends State<TestUserPreferences> {
  String _output = "";

  final String _testUserId = "testUser123"; // Substitua com um UID de teste.

  /// Função para criar o usuário de teste no Firestore.
  Future<void> _createTestUser() async {
    try {
      // Verifica se o usuário já existe
      var userSnapshot = await MasterController.fetchUserDataBase(_testUserId);

      if (!userSnapshot.exists) {
        // Cria um novo documento para o usuário no Firestore
        await userSnapshot.reference.set({
          'preferences': [],
          'maxStreak': 0,
          'currentStreak': 0,
        });

        setState(() {
          _output = "Usuário de teste criado com sucesso!\n";
        });
      } else {
        setState(() {
          _output = "Usuário de teste já existe. Continuando os testes...\n";
        });
      }
    } catch (e) {
      setState(() {
        _output = "Erro ao criar usuário de teste: $e";
      });
    }
  }

  /// Função para testar o `UserPreferencesController`.
  Future<void> _testUserPreferencesController() async {
    try {
      // Recuperar preferências
      Preferences? preferences =
          await UserPreferencesController.getUserPreferences(_testUserId);
      setState(() {
        _output += "Preferências atuais: ${preferences?.preferences ?? []}\n";
      });

      // Adicionar uma nova preferência
      await UserPreferencesController.addPreference(_testUserId, "ODS 1");
      setState(() {
        _output += "Adicionado ODS 1.\n";
      });

      // Adicionar uma nova preferência
      await UserPreferencesController.addPreference(_testUserId, "ODS 2");
      setState(() {
        _output += "Adicionado ODS 2.\n";
      });

      // Recuperar novamente
      preferences =
          await UserPreferencesController.getUserPreferences(_testUserId);
      setState(() {
        _output += "Após adicionar ODS 1 e ODS 2: ${preferences?.preferences ?? []}\n";
      });

      // Remover uma preferência
      await UserPreferencesController.removePreference(_testUserId, "ODS 1");
      setState(() {
        _output += "Removido ODS 1.\n";
      });

      // Recuperar novamente
      preferences =
          await UserPreferencesController.getUserPreferences(_testUserId);
      setState(() {
        _output += "Após remover ODS 1: ${preferences?.preferences ?? []}\n";
      });
    } catch (e) {
      setState(() {
        _output = "Erro durante os testes: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Cria o usuário e executa os testes
    _createTestUser().then((_) => _testUserPreferencesController());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Text(
          _output,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
