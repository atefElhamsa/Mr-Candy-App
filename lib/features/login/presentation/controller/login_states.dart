import 'package:mr_candy/features/login/data/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginFailureStates extends LoginStates {
  final String errorMessage;

  LoginFailureStates({required this.errorMessage});
}

class LoginSuccessStates extends LoginStates {
  final UserModel userModel;

  LoginSuccessStates({required this.userModel});
}
