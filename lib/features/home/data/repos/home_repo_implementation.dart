import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';
import 'package:mr_candy/features/home/data/models/category_model.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import 'package:mr_candy/features/home/data/repos/home_repo.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';

class HomeRepoImplementation implements HomeRepo {
  String get currentLanguage =>
      EasyLocalization.of(navigatorKey.currentContext!)?.locale.languageCode ??
      "ar";
  @override
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    List<BannerModel> banners = [];
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.banners),
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        for (var banner in body["data"]) {
          banners.add(
            BannerModel(
              image: banner["image"],
              id: banner["id"],
            ),
          );
        }
        return right(banners);
      } else {
        return left(
          ApiFailure(message: body["message"]),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (error) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    List<CategoryModel> categoriesList = [];
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.categories),
        headers: {
          "lang": currentLanguage,
        },
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        for (var category in body["data"]["data"]) {
          categoriesList.add(
            CategoryModel(
              id: category['id'],
              name: category['name'],
              image: category['image'],
            ),
          );
        }
        return right(categoriesList);
      } else {
        return left(
          ApiFailure(message: body["message"]),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (error) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getBestSellerProducts() async {
    List<ProductModel> productList = [];
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.home),
        headers: {
          "lang": currentLanguage,
        },
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        for (var product in body["data"]["products"]) {
          productList.add(ProductModel.fromJson(product));
        }
        return right(productList);
      } else {
        return left(
          ApiFailure(message: body["message"]),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (error) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCategoryDetails({
    required int id,
  }) async {
    List<ProductModel> categoryDetails = [];
    try {
      var response = await http.get(
        Uri.parse("${EndPoints.baseUrl + EndPoints.categories}/$id"),
        headers: {
          "lang": currentLanguage,
        },
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        for (var categoryDetail in body["data"]["data"]) {
          categoryDetails.add(ProductModel.fromJson(categoryDetail));
        }
        return right(categoryDetails);
      } else {
        return left(
          ApiFailure(message: body["message"]),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet"),
      );
    } catch (error) {
      return left(
        ApiFailure(message: "Error Occurred"),
      );
    }
  }
}
