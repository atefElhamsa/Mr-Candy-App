import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/payment_method_item.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final List<String> paymentImage = [AppImages.cardVisa, AppImages.paypal];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        reverse: isArabic ? true : false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                });
              },
              child: PaymentMethodItem(
                isActive: activeIndex == index,
                image: paymentImage[index],
              ),
            ),
          );
        },
        itemCount: paymentImage.length,
      ),
    );
  }
}
