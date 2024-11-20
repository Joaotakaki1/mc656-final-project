import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:mc656finalproject/models/ods.dart';

class OdsIcon extends StatelessWidget {
  final Map<String, TiposDeFiltros> ods;

  /// [ods]: Map contendo strings como chave e TiposDeFiltros como valor.
  const OdsIcon({super.key, required this.ods});

  @override
  Widget build(BuildContext context) {
    // Gera uma cor aleatória.
    final Color randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    // Exemplo: Exibe apenas o primeiro item do Map.
    final String firstKey = ods.keys.isNotEmpty ? ods.keys.first : "Sem Dados";
    final TiposDeFiltros? firstValue = ods[firstKey];

    return Container(
      constraints: const BoxConstraints(
        minWidth: 100, // Largura mínima para evitar "aperto" em textos pequenos
        maxWidth: 200, // Largura máxima
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: randomColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            firstKey,
            style: const TextStyle(
              color: blackText,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          if (firstValue != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                firstValue.descricao,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
