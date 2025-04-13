import 'package:dartz/dartz.dart';
import 'package:mr_candy/features/profile/data/model/profile_model.dart';

import '../../../../core/errors/failure.dart';

abstract class SettingRepo {
  Future<Either<Failure, ProfileModel>> getprofile();
  Future<Either<Failure, String>> changepassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<Either<Failure, String>> editprofile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
  });
}
