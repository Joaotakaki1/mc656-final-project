import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mc656finalproject/utils/colors.dart';

class OdsIcon extends StatelessWidget {
  final String ods;

  /// [ods]: Map contendo strings como chave e TiposDeFiltros como valor.
  const OdsIcon({super.key, required this.ods});

  @override
  Widget build(BuildContext context) {
    // Gera uma cor aleatória.
    String path = 'assets/icons/ods_icons/' + ods + '.png';

    Image ods_image = Image.asset(
                    path, // Coloque o caminho para a logo
                    width: 50, // Ajuste o tamanho da logo
                    height: 50,
                  );

    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 125,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
          border: Border.all(
          color: lightPink,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ods_image,
          Text(
            ods,
            style: const TextStyle(
              color: blackText,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible, // Permite quebra de linha
            softWrap: true, // Habilita quebra automática
          ),
        ],
      ),
    );
  }
}
