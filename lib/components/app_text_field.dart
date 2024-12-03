import 'package:flutter/material.dart';
import 'package:mc656finalproject/utils/colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final double vPadding;
  final double hPadding;
  final double bRadius;
  final bool password;
  const AppTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.vPadding,
    required this.hPadding,
    required this.bRadius,
    required this.password
    });

  @override
  _AppTextField createState() => _AppTextField();
}

class _AppTextField extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.password,
      decoration: InputDecoration(
        hintText: widget.text,
        contentPadding: EdgeInsets.symmetric(vertical: widget.vPadding, horizontal: widget.hPadding),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: darkPink, width: 2.0),
          borderRadius: BorderRadius.circular(widget.bRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: darkPink, width: 2.0),
          borderRadius: BorderRadius.circular(widget.bRadius),
        ),
      ),
    );
  }
}