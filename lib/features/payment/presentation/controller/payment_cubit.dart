import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_input_model.dart';
import 'package:mr_candy/features/payment/data/repo/checkout_repo.dart';
import 'package:mr_candy/features/payment/presentation/controller/payment_state.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit(this.checkOutRepo) : super(PaymentInitialState());
  final CheckOutRepo checkOutRepo;
  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(PaymentLoadingState());
    var data = await checkOutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold(
      (l) {
        emit(PaymentFailureState(l.message));
      },
      (r) {
        emit(PaymentSuccessState());
      },
    );
    @override
    void onChange(Change<PaymentStates> change) {
      print(change.toString());
      super.onChange(change);
    }
  }
}
