import 'package:flutter/material.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
import 'package:mc656finalproject/services/data_base_controller.dart';
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
      OdsIcon odsIcon = OdsIcon(ods: ods);
      available_ods_components.add(odsIcon);
    }
  }

  @override
  void initState() {
    super.initState();
    generateIcons(); // Gera os ícones assim que a tela for criada
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título
            const Align(
              alignment: Alignment.centerLeft,
                        child: Text(
                        "Estamos quase lá...",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Mas antes disso, escolha quais ODS você deseja focar:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 8),

            // Container para ODS Selecionadas
            Container(
              height: screenHeight * 0.35,
              constraints: const BoxConstraints(minWidth: double.infinity),
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
            const SizedBox(height: 8),
            // Container para ODS Não Selecionadas
            Container(
              height: screenHeight * 0.35,
              constraints: const BoxConstraints(minWidth: double.infinity),
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
                      "ODS Disponíveis:",
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
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () async {
                try {
                  List<String> stringPreferences = DataBaseController.turnODSIconInString(chosen_ods_components);
                  await DataBaseController.updateUserPreferences(
                      stringPreferences, widget.currentUser.uid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Preferências setadas com sucesso!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Erro ao tentar setar as preferêncuas, tente novamente mais tarde")),
                  );
                  print(e);
                }
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFED008C))),
              child: const Text(
                'Setar preferências',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
