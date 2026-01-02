import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;

  const AuthFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textHint),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
