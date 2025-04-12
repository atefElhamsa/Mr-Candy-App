import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_input_model.dart';
import 'package:mr_candy/features/payment/presentation/controller/payment_cubit.dart';
import 'package:mr_candy/features/payment/presentation/controller/payment_state.dart';
import 'package:mr_candy/features/payment/presentation/view/thank_you_screen.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomButtonBlockConsumer extends StatefulWidget {
  const CustomButtonBlockConsumer({super.key, required this.isLoading});
  final bool isLoading;

  @override
  State<CustomButtonBlockConsumer> createState() =>
      _CustomButtonBlockConsumerState();
}

class _CustomButtonBlockConsumerState extends State<CustomButtonBlockConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentStates>(
      listener: (context, state) {
        if (state is PaymentSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ThankYouScreen(),
            ),
          );
        }
        if (state is PaymentFailureState) {
          Navigator.pop(context);
          IconSnackBar.show(
            context,
            label: state.errorMessage,
            snackBarType: SnackBarType.alert,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: AppColors.loginAppbar2,
            iconColor: Colors.white,
            maxLines: 2,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: CustomButton(
            onTap: () async {
              setState(() => widget.isLoading);
              PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                amount: "${context.read<CartCubit>().totalPrice}",
                currency: 'USD',
                customerId: 'cus_S7HLZw6cZIZfrk',
              );
              BlocProvider.of<PaymentCubit>(context).makePayment(
                paymentIntentInputModel: paymentIntentInputModel,
              );
              for (var item in context.read<CartCubit>().cartList) {
                await BlocProvider.of<CartCubit>(context).updateCartQuantity(
                  item.id,
                  item.quantity,
                );
              }
              await context.read<CartCubit>().confirmCartUpdate();
              setState(() => widget.isLoading);
            },
            loading: state is PaymentLoadingState ? true : false,
            titleButton: AppTexts.sure,
          ),
        );
      },
    );
  }
}
