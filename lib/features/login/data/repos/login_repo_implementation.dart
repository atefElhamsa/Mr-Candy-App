import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/core/utils/end_points.dart';
import 'package:mr_candy/features/login/data/models/user_model.dart';
import 'package:mr_candy/features/login/data/repos/login_repo.dart';
import 'package:http/http.dart' as http;

class LoginRepoImplementation implements LoginRepo {
  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var result = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.login),
        body: {"email": email, "password": password},
      );
      var body = jsonDecode(result.body);
      if (body["status"]) {
        return right(
          UserModel(
            id: body["data"]["id"],
            name: body["data"]["name"],
            email: body["data"]["email"],
            phone: body["data"]["phone"],
            image: body["data"]["image"],
            points: body["data"]["points"],
            credit: body["data"]["credit"],
            token: body["data"]["token"],
          ),
        );
      } else {
        return left(
          ApiFailure(message: body["message"]),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: AppTexts.noInternet),
      );
    } catch (error) {
      return left(
        ApiFailure(message: AppTexts.errorOccurred),
      );
    }
  }
}
