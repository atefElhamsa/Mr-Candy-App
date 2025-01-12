import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';
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
}