import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/carts/data/model/cart_model.dart';
import 'package:mr_candy/features/carts/data/repo/carts_repo.dart';
import 'package:http/http.dart' as http;
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_cubit.dart';

class CartRepoImplementation implements CartRepo {
  int totalPrice = 0;

  @override
  Future<Either<Failure, CartModel>> addCart({context, index}) async {
    final token = Hive.box(AppTexts.nameOfBox).get("token");
    if (token == null || token.isEmpty) {
      return left(
        ApiFailure(message: "Authentication token is missing."),
      );
    }
    try {
      final Map<String, dynamic> body = {
        "product_id": BlocProvider.of<CategoryDetailsCubit>(context)
            .categoryDetails[index]
            .id
            .toString(),
      };
      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.carts),
        headers: {
          "Authorization": "$token",
          "lang": "ar",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"]) {
          final cartItemData = body["data"];
          final cartModel = CartModel.fromJson(cartItemData);
          return right(cartModel);
        } else {
          return left(
            ApiFailure(message: body["message"] ?? "Failed to add to cart"),
          );
        }
      } else {
        return left(
          ApiFailure(message: "Failed to fetch data"),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (e) {
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> getCarts() async {
    final token = Hive.box(AppTexts.nameOfBox).get("token");
    try {
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.carts),
        headers: {
          "Authorization": "$token",
          "lang": "ar",
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        totalPrice = body["data"]["total"].toInt();
        if (body["status"]) {
          List<CartModel> cartList = body["data"]["cart_items"]
              .map<CartModel>((product) => CartModel.fromJson(product))
              .toList();
          return right(cartList);
        } else {
          return left(
            ApiFailure(message: body["message"] ?? "Unknown error"),
          );
        }
      } else {
        return left(
          ApiFailure(message: "Failed to fetch data"),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> updateCarts({
    required int idCart,
    required int quantity,
  }) async {
    final token = Hive.box(AppTexts.nameOfBox).get("token");
    try {
      final response = await http.put(
        Uri.parse("${EndPoints.baseUrl + EndPoints.carts}/$idCart"),
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/json",
        },
        body: {
          jsonEncode({
            "quantity": quantity.toInt(),
          })
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"] != true) {
          return left(
            ApiFailure(message: body["message"] ?? "Unknown error"),
          );
        }
        totalPrice = body["data"]["total"]?.toInt() ?? 0;
        final List<CartModel> cartItem = [];
        if (body["data"].containsKey("cart_items") &&
            body["data"]["cart_items"] != null) {
          final List<dynamic> cartItemsJson = body["data"]["cart_items"];
          cartItem.addAll(
            cartItemsJson.map(
              (e) => CartModel.fromJson(e),
            ),
          );
        } else {
          if (kDebugMode) {
            print("Warning: 'cart_items' not found in response");
          }
        }
        return right(cartItem);
      } else {
        return left(
          ApiFailure(message: "Failed to fetch data"),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (e) {
      return left(ApiFailure(message: "Error Occurred"));
    }
  }

  @override
  Future<Either<Failure, CartModel>> deleteCarts({context, index}) async {
    final token = Hive.box(AppTexts.nameOfBox).get("token");
    if (token == null || token.isEmpty) {
      return left(
        ApiFailure(message: "Authentication token is missing."),
      );
    }
    try {
      final response = await http.delete(
        Uri.parse(
            "${EndPoints.baseUrl + EndPoints.carts}/${BlocProvider.of<CartCubit>(context).cartList[index].id.toString()}"),
        headers: {
          "Authorization": "$token",
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"]) {
          final cartItemData = body["data"];
          final cartModel = CartModel.fromJson(cartItemData);
          return right(cartModel);
        } else {
          return left(
            ApiFailure(
                message: body["message"] ?? "Failed to delete from cart"),
          );
        }
      } else {
        return left(
          ApiFailure(message: "Failed to fetch data"),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }
}
