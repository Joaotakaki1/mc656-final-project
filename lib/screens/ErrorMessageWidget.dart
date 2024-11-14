import 'package:flutter/material.dart';
import 'package:mc656finalproject/utils/colors.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final VoidCallback onClose;

  const ErrorMessageWidget({
    super.key,
    required this.message,
    required this.onClose,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
    	padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: lightPink,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: blackText),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: blackText),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: darkPink),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
