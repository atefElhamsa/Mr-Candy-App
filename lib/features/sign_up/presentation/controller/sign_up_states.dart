import 'package:mr_candy/features/login/data/models/user_model.dart';

abstract class SignUpStates {}

class SignUpInitialStates extends SignUpStates {}

class PickedImageStates extends SignUpStates {}

class SignUpLoadingStates extends SignUpStates {}

class SignUpFailureStates extends SignUpStates {
  final String errorMessage;

  SignUpFailureStates({required this.errorMessage});
}

class SignUpSuccessStates extends SignUpStates {
  final UserModel userModel;

  SignUpSuccessStates({required this.userModel});
}
