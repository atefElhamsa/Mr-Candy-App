import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/carts/presentation/view/widgets/cart_body.dart';
import '../../../../core/shared_widgets/app_bar_widget.dart';
import '../../../../core/utils/app_texts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: const AppBarWidgetWithoutBack(name: AppTexts.homeCarts),
      ),
      body: BlocProvider(
        create: (context) => CartCubit()..fetchCarts(),
        child: const CartBody(),
      ),
    );
  }
}
