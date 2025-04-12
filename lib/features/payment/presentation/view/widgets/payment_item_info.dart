import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class PaymentItemInfo extends StatelessWidget {
  PaymentItemInfo({super.key, required this.title, required this.value, this.dollar});
  final String title, value;
  String? dollar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
          Text(
            dollar!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
