import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/features/carts/data/model/cart_model.dart';
import 'package:mr_candy/features/carts/data/repo/carts_repo_implementation.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_states.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());
  final CartRepoImplementation cartRepoImplementation =
      CartRepoImplementation();
  List<CartModel> cartList = [];
  int totalPrice = 0;

  Future<void> fetchCarts() async {
    emit(CartLoadingState());
    final result = await cartRepoImplementation.getCarts();
    result.fold(
      (l) {
        emit(CartFailureState(errorMessage: l.message));
      },
      (r) {
        cartList = r;
        totalPrice = cartRepoImplementation.totalPrice;
        emit(CartSuccessState(cartList: cartList));
      },
    );
  }

  Future<void> addCart(BuildContext context, int index) async {
    final result = await cartRepoImplementation.addCart(
      context: context,
      index: index,
    );
    result.fold(
      (l) {
        emit(CartFailureState(errorMessage: l.message));
      },
      (r) {
        if (index < cartList.length) {
          cartList[index] = r;
        } else {
          cartList.add(r);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.green,
            showCloseIcon: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            content: Text(
              AppTexts.addFav,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.h,
              ),
            ),
          ),
        );
        emit(CartSuccessState(cartList: cartList));
      },
    );
  }

  Future<void> deleteCart(context, int index) async {
    final result = await cartRepoImplementation.deleteCarts(
      context: context,
      index: index,
    );
    result.fold(
      (l) {
        emit(CartFailureState(errorMessage: l.message));
      },
      (r) {
        emit(CartLoadingState());
        cartList.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.red,
            showCloseIcon: true,
            duration: const Duration(seconds: 1),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            behavior: SnackBarBehavior.floating,
            content: Text(
              AppTexts.delFav,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.h,
              ),
            ),
          ),
        );
        emit(CartSuccessState(cartList: cartList));
      },
    );
  }

  Future<void> updateCartQuantity(int cartId, int newQuantity) async {
    final result = await cartRepoImplementation.updateCarts(
      idCart: cartId,
      quantity: newQuantity,
    );
    result.fold(
      (l) {
        emit(CartFailureState(errorMessage: l.message));
      },
      (r) {
        cartList = r;
        totalPrice = r.fold(
          0,
          (sum, item) => sum + (item.productModel.price * item.quantity),
        );
        emit(CartSuccessState(cartList: cartList));
      },
    );
  }

  Future<void> confirmCartUpdate() async {
    for (var item in cartList) {
      await cartRepoImplementation.updateCarts(
        idCart: item.id,
        quantity: item.quantity,
      );
    }
    await fetchCarts();
  }
}
