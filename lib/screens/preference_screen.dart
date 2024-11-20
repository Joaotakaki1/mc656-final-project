import 'package:flutter/material.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
import 'package:mc656finalproject/services/ods.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:mc656finalproject/utils/ods.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});
  
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
      appBar: AppBar(
        title: const Text("Ajustes de Preferências"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Estamos quase lá... Selecione quais os tipos de desafio você deseja receber.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Containers para OdsIcons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container de Ods selecionados
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    color: darkPink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView(
                    children: chosen_ods_components,
                  ),
                ),
                const SizedBox(width: 16),
                // Container de Ods disponíveis
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    color: lightPink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView(
                    children: available_ods_components.map((odsIcon) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Adiciona o ícone na lista de selecionados
                            chosen_ods_components.add(odsIcon);
                            available_ods_components.remove(odsIcon);
                          });
                        },
                        child: odsIcon,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

