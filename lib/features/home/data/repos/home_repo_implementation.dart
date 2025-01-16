import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';
import 'package:mr_candy/features/home/data/models/category_model.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import 'package:mr_candy/features/home/data/repos/home_repo.dart';
import 'package:http/http.dart' as http;

class HomeRepoImplementation implements HomeRepo {
  @override
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.banners),
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        var result = List<BannerModel>.from(
          (body["data"] as List).map(
            (e) => BannerModel(image: e["image"], id: e["id"]),
          ),
        );
        return right(result);
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
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.categories),
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        var result = List<CategoryModel>.from(
          (body["data"]["data"] as List).map(
            (e) =>
                CategoryModel(image: e["image"], id: e["id"], name: e["name"]),
          ),
        );
        return right(result);
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
    try {
      var response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.home),
      );
      var body = jsonDecode(response.body);
      if (body["status"]) {
        var result = List<ProductModel>.from(
          (body["data"]["products"] as List).map(
            (e) => ProductModel(
              id: e["id"],
              description: e["description"],
              discount: e["discount"],
              inCart: e["in_cart"],
              inFavorites: e["in_favorites"],
              name: e["name"],
              oldPrice: e["old_price"],
              price: e["price"],
              image: e["image"],
            ),
          ),
        );
        return right(result);
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
