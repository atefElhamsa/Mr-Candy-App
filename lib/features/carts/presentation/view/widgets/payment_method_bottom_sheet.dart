import 'package:flutter/material.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/custom_button_block_consumer.dart';
import 'package:mr_candy/features/payment/presentation/view/widgets/payment_method.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({super.key, required this.isLoading, required this.totalPrice});
  final bool isLoading;
  final num totalPrice;

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const PaymentMethod(),
          const SizedBox(height: 20),
          CustomButtonBlockConsumer(
            isLoading: widget.isLoading,
            totalPrice: widget.totalPrice,
          ),
        ],
      ),
    );
  }
}
