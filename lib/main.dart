import 'package:flutter/material.dart';
import 'package:mc656finalproject/firebase_options.dart';
import 'package:mc656finalproject/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mc656finalproject/services/challenge_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChallengeController([]))
      ],
      child: const MyApp()) 
    );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto MC656',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFED008C)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}