import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.onIconPressed,
  });
  final String hintText;
  final String label;
  TextEditingController controller;
  VoidCallback? onIconPressed;
  bool obscureText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(onPressed: onIconPressed, icon: Icon(icon)),
          hintText: hintText,
          label: Text(label)),
    );
  }
}
