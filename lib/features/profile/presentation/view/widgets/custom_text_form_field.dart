import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final bool? obscureText;
  final FocusNode? focusNode;
  void Function(String)? onFieldSubmitted;
  CustomTextFormField({
    super.key,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == ui.TextDirection.rtl;
    return TextFormField(
      textDirection: isRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      textAlign: isRTL ? TextAlign.right : TextAlign.left,
      controller: controller,
      autofocus: false,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
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
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.almarai(
          color: AppColors.iconsFormFieldColor,
        ),
      ),
    );
  }
}
