import 'package:flutter/material.dart';
import 'package:mc656finalproject/models/user.dart';
import 'package:mc656finalproject/screens/preference_screen.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
import 'package:mc656finalproject/utils/colors.dart';

class ConfigScreen extends StatelessWidget {
  final User currentUser;
  const ConfigScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/decorationUpper.png',
            fit: BoxFit.fill,
            width: double.maxFinite,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Configurações',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(254, 242, 0, 1)),
                    ),
                    GestureDetector(
                      child: Image.asset('assets/icons/home.png'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          color: darkPink,
                        ),
                        title: const Text('Alterar Senha'),
                        onTap: () {
                          DataBaseController.sendPasswordResetEmail(
                              context, currentUser.email);
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.notifications, color: darkPink),
                        title: const Text('Alterar Preferências'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreferenceScreen(
                                      currentUser: currentUser,
                                    )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
