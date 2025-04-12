import 'package:dartz/dartz.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_input_model.dart';

import '../../../../core/errors/failure.dart';

abstract class CheckOutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
