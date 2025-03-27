import 'package:equatable/equatable.dart';
import 'package:mr_candy/features/carts/data/model/cart_model.dart';

abstract class CartStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartFailureState extends CartStates {
  final String errorMessage;

  CartFailureState({required this.errorMessage});
}

class CartSuccessState extends CartStates {
  final List<CartModel> cartList;

  CartSuccessState({required this.cartList});
}
