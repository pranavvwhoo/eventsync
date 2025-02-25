import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Color borderColor;
  final Color hintTextColor;
  final Function(String)? onChanged;
  final IconData? suffixIcon;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.borderColor = const Color(0xff9CA3AF),
    this.hintTextColor = Colors.grey,
    this.onChanged,
    this.suffixIcon, required bool obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        hintStyle: GoogleFonts.inter(
          letterSpacing: 0.1,
          color: hintTextColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
