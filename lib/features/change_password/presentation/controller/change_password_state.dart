abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordFailureState extends ChangePasswordStates {
  final String errorMessage;

  ChangePasswordFailureState({required this.errorMessage});
}

class ChangePasswordSuccessState extends ChangePasswordStates {
  final String message;

  ChangePasswordSuccessState({required this.message});
}
