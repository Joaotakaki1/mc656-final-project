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
  List<OdsIcon> chosenOdsComponents = [];
  List<OdsIcon> availableOdsComponents = [];
  List<String> availableOds = Ods.ods;

  // Gera os ícones disponíveis
  void generateIcons() {
    availableOdsComponents.clear(); // Limpa a lista antes de gerar novamente
    for (String ods in availableOds) {
      OdsIcon odsIcon = OdsIcon(ods: ods);
      availableOdsComponents.add(odsIcon);
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
      appBar: AppBar(
        title: const Text("Ajustes de Preferências"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                    width: screenWidth * 0.4,
                    height: screenHeight, // Ajuste a altura conforme necessário
                    decoration: BoxDecoration(
                      color: darkPink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView(
                      children: chosenOdsComponents.map((odsIcon) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Remove o ícone da lista de selecionados
                              chosenOdsComponents.remove(odsIcon);
                              // Adiciona o ícone de volta na lista de disponíveis
                              availableOdsComponents.add(odsIcon);
                            });
                          },
                          child: odsIcon,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Container de Ods disponíveis
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight, // Ajuste a altura conforme necessário
                    decoration: BoxDecoration(
                      color: lightPink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView(
                      children: availableOdsComponents.map((odsIcon) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Adiciona o ícone na lista de selecionados
                              chosenOdsComponents.add(odsIcon);
                              // Remove o ícone da lista de disponíveis
                              availableOdsComponents.remove(odsIcon);
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
      ),
    );
  }
}