import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/carts/data/model/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> addCart();
  Future<Either<Failure, List<CartModel>>> getCarts();
  Future<Either<Failure, List<CartModel>>> updateCarts({
    required int idCart,
    required int quantity,
  });
  Future<Either<Failure, CartModel>> deleteCarts();
}
