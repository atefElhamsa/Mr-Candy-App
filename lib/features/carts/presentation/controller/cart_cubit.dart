import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/carts/data/model/cart_model.dart';
import 'package:mr_candy/features/carts/data/repo/carts_repo_implementation.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_states.dart';

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
