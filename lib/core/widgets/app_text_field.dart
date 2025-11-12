import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
