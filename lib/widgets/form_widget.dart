import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final int? maxLines;
  final double? fontSize;
  final TextEditingController controller;
  final String hintText;

  const FormWidget(
      {super.key,
      required this.controller,
      this.fontSize,
      required this.hintText,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: TextStyle(fontSize: fontSize, color: Colors.white70),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
