abstract class PaymentStates {}

class PaymentInitialState extends PaymentStates {}

class PaymentLoadingState extends PaymentStates {}

class PaymentSuccessState extends PaymentStates {}

class PaymentFailureState extends PaymentStates {
  final String errorMessage;

  PaymentFailureState(this.errorMessage);
}
