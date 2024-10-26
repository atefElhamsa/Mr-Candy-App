import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/login/data/models/user_model.dart';
import 'package:mr_candy/features/sign_up/data/models/sign_up_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserModel>> signUp({
    required UserSignUpModel userSignUpModel,
  });
}
