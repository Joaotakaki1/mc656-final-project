import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/master_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasterController Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String result = "Press a button to test";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MasterController Test'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              buildTestButton(
                label: 'Insert User',
                onPressed: () async {
                  try {
                    await insertUser();
                    setState(() {
                      result = 'User inserted successfully!';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error inserting user: $e';
                    });
                  }
                },
              ),
              buildTestButton(
                label: 'Fetch User Preferences',
                onPressed: () async {
                  String email = 'testuser@example.com';
                  try {
                    List<String> preferences =
                        await MasterController.fetchUserPreferences(email);
                    setState(() {
                      result = 'User Preferences: $preferences';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error: $e';
                    });
                  }
                },
              ),
              buildTestButton(
                label: 'Fetch User Streak',
                onPressed: () async {
                  String email = 'testuser@example.com';
                  try {
                    List<int> streak =
                        await MasterController.fetchUserStreak(email);
                    setState(() {
                      result =
                          'User Streak: Max - ${streak[0]}, Current - ${streak[1]}';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error: $e';
                    });
                  }
                },
              ),
              buildTestButton(
                label: 'Update User Preferences',
                onPressed: () async {
                  String email = 'testuser@example.com';
                  List<String> newPreferences = ['ODS 12', 'ODS 13'];
                  try {
                    await MasterController.updateUserPreferences(
                        newPreferences, email);
                    setState(() {
                      result = 'Updated Preferences: $newPreferences';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error: $e';
                    });
                  }
                },
              ),
              buildTestButton(
                label: 'Update User Streak',
                onPressed: () async {
                  String email = 'testuser@example.com';
                  int maxStreak = 5;
                  int currentStreak = 3;
                  try {
                    await MasterController.updateUserStreak(
                        maxStreak, currentStreak, email);
                    setState(() {
                      result =
                          'Updated Streak: Max - $maxStreak, Current - $currentStreak';
                    });
                  } catch (e) {
                    setState(() {
                      result = 'Error: $e';
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to insert a new user into the Firestore database
  Future<void> insertUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    try {
      await users.add({
        'email': 'testuser@example.com',
        'preferences': ['ODS 1', 'ODS 2'],
        'maxStreak': 10,
        'currentStreak': 2,
      });
      print("User added successfully.");
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }

  Widget buildTestButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
