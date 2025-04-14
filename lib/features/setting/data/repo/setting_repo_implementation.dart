import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/profile/data/model/profile_model.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo.dart';
import '../../../../core/extensions/token.dart';
import '../../../../core/utils/end_points.dart';

class SettingRepoImplementation implements SettingRepo {
  @override
  Future<Either<Failure, ProfileModel>> getprofile() async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        return left(
          ApiFailure(message: "Authentication token is missing."),
        );
      }
      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.profile),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody["status"] == true) {
          final profileModel = ProfileModel.fromJson(responseBody["data"]);
          if (responseBody["data"]["token"] != token) {
            AuthHelper.saveToken(responseBody["data"]["token"]);
          }
          return right(profileModel);
        } else {
          return left(
            ApiFailure(
              message: responseBody["message"] ?? "Failed to fetch profile",
            ),
          );
        }
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(
          ApiFailure(message: "Unauthorized: Please login again."),
        );
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
        NoInternetFailure(message: "No Internet Connection"),
      );
    } on FormatException {
      return left(
        ApiFailure(message: "Invalid response format"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "An unexpected error occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> changepassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        return left(
          ApiFailure(message: "Authentication token is missing."),
        );
      }
      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.changepassword),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(
          responseBody["message"] ?? "Password changed successfully",
        );
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(
          ApiFailure(message: "Unauthorized: Please login again."),
        );
      } else {
        return left(
          ApiFailure(
            message: responseBody["message"] ?? "Failed to change password",
          ),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet Connection"),
      );
    } on FormatException {
      return left(
        ApiFailure(message: "Invalid response format"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "An unexpected error occurred"),
      );
    }
  }

  @override
  Future<Either<Failure, String>> editprofile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
  }) async {
    try {
      final token = AuthHelper.getToken();

      if (token == null || token.isEmpty) {
        return left(ApiFailure(message: "Authentication token is missing."));
      }
      final response = await http.put(
        Uri.parse(EndPoints.baseUrl + EndPoints.updateProfile),
        headers: {
          "Authorization": token,
          "Accept": "application/json",
        },
        body: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "image": image
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return right(responseBody["message"] ?? "Edit profile successfully");
      } else if (response.statusCode == 401) {
        AuthHelper.removeToken();
        return left(
          ApiFailure(message: "Unauthorized: Please edit again."),
        );
      } else {
        return left(
          ApiFailure(
            message: responseBody["message"] ?? "Failed to Edit profile",
          ),
        );
      }
    } on SocketException {
      return left(
        NoInternetFailure(message: "No Internet Connection"),
      );
    } on FormatException {
      return left(
        ApiFailure(message: "Invalid response format"),
      );
    } catch (e) {
      return left(
        ApiFailure(message: "An unexpected error occurred"),
      );
    }
  }
}
