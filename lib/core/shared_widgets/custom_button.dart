import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.titleButton,
    this.onTap,
    this.loading = false,
  });

  final String titleButton;
  void Function()? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: loading
            ? null
            : BoxDecoration(
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
          child: loading
              ? const CircularProgressIndicator()
              : Text(
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
