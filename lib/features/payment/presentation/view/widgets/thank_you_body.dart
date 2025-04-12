import 'package:flutter/material.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/custom_check_icon.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/thank_you_card.dart';

import '../../../../../core/utils/app_colors.dart';

class ThankYouBody extends StatelessWidget {
  const ThankYouBody({super.key, required this.totalPrice});
  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouCard(totalPrice: totalPrice,),
          Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * 0.2,
            child: const CircleAvatar(
              backgroundColor: AppColors.white,
            ),
          ),
          Positioned(
            right: -20,
            bottom: MediaQuery.sizeOf(context).height * 0.2,
            child: const CircleAvatar(
              backgroundColor: AppColors.white,
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: -50,
            child: CustomCheckIcon(),
          )
        ],
      ),
    );
  }
}
