import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'dart:ui' as ui;

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.keyboardType,
    required this.hintTitle,
    required this.iconData,
    required this.errorMessage,
    required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    required this.obscureText,
  });

  final TextInputType keyboardType;
  final String hintTitle;
  final IconData iconData;
  final String errorMessage;
  final TextEditingController controller;
  final FocusNode? focusNode;
  void Function(String)? onFieldSubmitted;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == ui.TextDirection.rtl;
    return TextFormField(
      textDirection: isRTL ? ui.TextDirection.ltr :ui.TextDirection.rtl,
      textAlign: isRTL ? TextAlign.left : TextAlign.right,
      focusNode: focusNode,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintTitle,
        hintStyle: GoogleFonts.almarai(
            color: AppColors.iconsFormFieldColor,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.02,
          ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              child: VerticalDivider(
                color: AppColors.iconsFormFieldColor,
                thickness: MediaQuery.of(context).size.width * 0.005,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.015,
            ),
            Icon(
              iconData,
              color: AppColors.iconsFormFieldColor,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
          ],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.03,
          ),
          borderSide: const BorderSide(color: AppColors.iconsFormFieldColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.03,
          ),
          borderSide: const BorderSide(color: AppColors.iconsFormFieldColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.03,
          ),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.03,
          ),
          borderSide: const BorderSide(color: AppColors.iconsFormFieldColor),
        ),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty == true) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
