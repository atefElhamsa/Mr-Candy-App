import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/features/payment/presentation/view/thank_you_screen.dart';

import '../../../../core/shared_widgets/app_bar_widget.dart';
import '../../../../core/utils/app_texts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.totalPrice});
  final num totalPrice;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        flexibleSpace: const AppBarWidgetWithoutBack(name: AppTexts.payment),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                    } else {
                      setState(() {
                        autoValidateMode = AutovalidateMode.always;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThankYouScreen(totalPrice: widget.totalPrice,),
                          ),
                        );
                      });
                    }
                  },
                  titleButton: AppTexts.sure,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
