import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;
  const CustomTextFormField({
    super.key,
    required this.keyboardType,
    required this.suffixIcon,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: GoogleFonts.almarai(
        color: AppColors.loginAppbar3,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.iconsFormFieldColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.iconsFormFieldColor,
            width: 2.0,
          ),
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.almarai(
          color: AppColors.iconsFormFieldColor,
        ),
      ),
    );
  }
}
