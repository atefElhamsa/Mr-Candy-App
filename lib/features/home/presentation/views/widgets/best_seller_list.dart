import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/features/home/presentation/controller/get_best_seller_product_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_best_seller_product_states.dart';
import 'package:mr_candy/features/home/presentation/views/widgets/best_seller_widget.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerProductsCubit, BestSellerProductsStates>(
      builder: (context, state) {
        if (state is BestSellerProductsLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BestSellerProductsFailureStates) {
          return FailureWidget(
            errorMessage: state.errorMessage,
            onPressed: () {
              BlocProvider.of<BestSellerProductsCubit>(context).getBestSellerProducts();
            },
          );
        } else if (state is BestSellerProductsSuccessStates) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return BestSellerWidget(productModel: state.products[index]);
            },
            separatorBuilder: (context, index) {
              return 20.horizontalSpace;
            },
            itemCount: state.products.length,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
