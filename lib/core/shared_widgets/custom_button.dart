import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.titleButton,
    this.onTap,
  });

  final String titleButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.buttonColor2,
              AppColors.buttonColor1,
              AppColors.buttonColor3,
              AppColors.buttonColor2,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              MediaQuery.of(context).size.width * 0.02,
            ),
          ),
        ),
        child: Center(
          child: Text(
            titleButton,
            style: GoogleFonts.almarai(
              textStyle: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height * 0.025,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
