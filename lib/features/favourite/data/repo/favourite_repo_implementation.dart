import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/favourite/data/model/favourite_model.dart';
import 'package:mr_candy/features/favourite/data/repo/favourite_repo.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import '../../../../core/utils/app_texts.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/presentation/controller/get_category_details_cubit.dart';

class FavouriteRepoImplementation implements FavouriteRepo {
  String get currentLanguage =>
      EasyLocalization.of(navigatorKey.currentContext!)?.locale.languageCode ??
      "ar";

  @override
  Future<Either<Failure, List<FavouriteItemModel>>> getFavourite() async {
    List<FavouriteItemModel> favouriteList = [];
    final token = Hive.box(AppTexts.nameOfBox).get("token");
    try {
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
        headers: {
          "Authorization": "$token",
          "lang": currentLanguage,
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"]) {
          favouriteList = [];
          for (var item in body["data"]["data"]) {
            try {
              favouriteList.add(FavouriteItemModel.fromJson(item));
            } catch (e) {
              print("Error processing product: $e");
            }
          }
          return right(favouriteList);
        } else {
          return left(
            ApiFailure(message: body["message"] ?? "Unknown error"),
          );
        }
      } else {
        return left(
          ApiFailure(
            message:
                "Failed to fetch data, Status code: ${response.statusCode}",
          ),
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
  Future<Either<Failure, void>> deleteFavourite({
    required BuildContext context,
    required int index,
  }) async {
    try {
      final token = Hive.box(AppTexts.nameOfBox).get("token");
      if (token == null || token.isEmpty) {
        return left(
          ApiFailure(message: "Authentication token is missing."),
        );
      }
      final itemId =
          BlocProvider.of<FavouriteCubit>(context).favouriteList[index].id;
      final response = await http.delete(
        Uri.parse("${EndPoints.baseUrl}${EndPoints.favorites}/$itemId"),
        headers: {
          "Authorization": "$token",
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"]) {
          return const Right(null);
        } else {
          return left(
            ApiFailure(message: body["message"] ?? "Failed to delete item"),
          );
        }
      } else {
        return left(
          ApiFailure(
            message: "Failed to delete, Status code: ${response.statusCode}",
          ),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet connection"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "An unexpected error occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, ProductModel>> addFavourite({
    required BuildContext context,
    required int index,
  }) async {
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
        Uri.parse(EndPoints.baseUrl + EndPoints.favorites),
        headers: {
          "Authorization": "$token",
          "lang": currentLanguage,
        },
        body: body,
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body["status"] == true) {
          final productData = body["data"]["product"];
          final productModel = ProductModel.fromJson(productData);
          return right(productModel);
        } else {
          return left(
            ApiFailure(
                message: body["message"] ?? "Failed to add to favorites"),
          );
        }
      } else {
        return left(
          ApiFailure(
              message:
                  "Failed to fetch data, Status code: ${response.statusCode}"),
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
