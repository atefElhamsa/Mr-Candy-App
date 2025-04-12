import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/cart_info_widget.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/payment_item_info.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({super.key, required this.totalPrice});
  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 800.h,
      decoration: ShapeDecoration(
        color: AppColors.loginAppbar3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50 + 16),
        child: Column(
          children: [
            Text(
              AppTexts.thankYou,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            Text(
              AppTexts.successful,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            PaymentItemInfo(
              title: AppTexts.date,
              value:
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              dollar: "",
            ),
            PaymentItemInfo(
              title: AppTexts.time,
              value: TimeOfDay.fromDateTime(DateTime.now()).format(context),
              dollar: "",
            ),
            PaymentItemInfo(
              title: AppTexts.to,
              value: "Atef",
              dollar: "",
            ),
            const SizedBox(height: 15),
            Divider(
              thickness: 2,
              indent: 15.w,
              endIndent: 15.w,
            ),
            const SizedBox(height: 20),
            PaymentItemInfo(
              title: AppTexts.total,
              value: "${(totalPrice / 50)}",
              dollar: r" $",
            ),
            const SizedBox(height: 10),
            const CartInfoWidget(),
            const SizedBox(height: 13),
            const DottedLine(
              dashColor: AppColors.white,
              lineThickness: 1,
              lineLength: 300,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  FontAwesomeIcons.barcode,
                  size: 60,
                ),
                Container(
                  width: 113.w,
                  height: 85.h,
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(width: 2, color: AppColors.green),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppTexts.paid,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ((MediaQuery.sizeOf(context).height * 0.2 + 20) / 2) - 29,
            ),
          ],
        ),
      ),
    );
  }
}
