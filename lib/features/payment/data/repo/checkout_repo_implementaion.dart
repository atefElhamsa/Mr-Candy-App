import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/core/extensions/stripe_services.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_input_model.dart';
import 'package:mr_candy/features/payment/data/repo/checkout_repo.dart';

class CheckOutRepoImplementation implements CheckOutRepo {
  final StripeServices stripeService = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return right(null);
    } catch (e) {
      return left(
        ServiceFailure(message: e.toString()),
      );
    }
  }
}
