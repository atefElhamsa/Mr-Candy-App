import 'package:flutter/material.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/thank_you_body.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key, required this.totalPrice});
  final num totalPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          ),
        ),
      ),
      body: Transform.translate(
        offset: const Offset(0, 30),
        child: ThankYouBody(totalPrice: totalPrice,),
      ),
    );
  }
}
