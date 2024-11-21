import 'package:flutter/material.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
import 'package:mc656finalproject/services/ods.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:mc656finalproject/utils/ods.dart';
import '../models/user.dart';

class PreferenceScreen extends StatefulWidget {
  final User currentUser;
  const PreferenceScreen({super.key, required this.currentUser});
  
  @override
  _PreferenceScreen createState() => _PreferenceScreen();
}

class _PreferenceScreen extends State<PreferenceScreen> {
  List<OdsIcon> chosen_ods_components = [];
  List<OdsIcon> available_ods_components = [];
  List<String> available_ods = Ods.ods;

  // Gera os ícones disponíveis
  void generateIcons() {
    available_ods_components.clear(); // Limpa a lista antes de gerar novamente
    for (String ods in available_ods) {
      OdsIcon ods_icon = OdsIcon(ods: ods);
      available_ods_components.add(ods_icon);
    }
  }

  @override
  void initState() {
    super.initState();
    generateIcons(); // Gera os ícones assim que a tela for criada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título
            const Text(
              "Estamos quase lá... ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mas antes disso, escolha quais ODS você deseja focar:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 16),

            // Container para ODS Selecionadas
            Container(
              height: 200,
              constraints: const BoxConstraints(
                minWidth: double.infinity
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkPink,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "ODS Selecionadas:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkPink,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 2,
                        runSpacing: 2,
                        children: chosen_ods_components.map((odsIcon) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                available_ods_components.add(odsIcon);
                                chosen_ods_components.remove(odsIcon);
                              });
                            },
                            child: odsIcon,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Container para ODS Não Selecionadas
            Container(
              height: 200,
              constraints: const BoxConstraints(
                minWidth: double.infinity
              ),
              color: lightPink,
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkPink,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "ODS Não Selecionadas:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkPink,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 2,
                        runSpacing: 2,
                        children: available_ods_components.map((odsIcon) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                chosen_ods_components.add(odsIcon);
                                available_ods_components.remove(odsIcon);
                              });
                            },
                            child: odsIcon,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Botão de "Confirmar"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica do botão
                  print("ODS confirmadas!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkPink, // Cor darkPink
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}