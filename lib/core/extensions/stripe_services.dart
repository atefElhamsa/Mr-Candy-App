import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mr_candy/core/extensions/api_end_points.dart';
import 'package:mr_candy/core/extensions/api_keys.dart';
import 'package:mr_candy/core/extensions/api_service.dart';
import 'package:mr_candy/features/payment/data/model/ephemeralkey_model.dart';
import 'package:mr_candy/features/payment/data/model/init_payment_sheet_model.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_input_model.dart';
import 'package:mr_candy/features/payment/data/model/payment_intent_model.dart';

class StripeServices {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    final response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: ApiEndPoints.createStripe,
      token: ApiKeys.secretKey,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
      },
    );
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    if (!jsonResponse.containsKey('client_secret') ||
        jsonResponse['client_secret'] == null) {
      throw Exception(
          'Stripe API response missing client_secret: $jsonResponse');
    }
    return PaymentIntentModel.fromJson(jsonResponse);
  }

  Future<void> initPaymentSheet({
    required InitPaymentSheetModel initPaymentSheetModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initPaymentSheetModel.clientSecret,
        customerEphemeralKeySecret: initPaymentSheetModel.ephemeralKeySecret,
        customerId: initPaymentSheetModel.customerId,
        merchantDisplayName: "Atef",
      ),
    );
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralkeyModel = await createEphemeralKey(
      customerId: paymentIntentInputModel.customerId,
    );
    var initPaymentSheetModel = InitPaymentSheetModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: paymentIntentInputModel.customerId!,
      ephemeralKeySecret: ephemeralkeyModel.secret!,
    );
    await initPaymentSheet(initPaymentSheetModel: initPaymentSheetModel);
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    final response = await apiService.post(
        body: {
          'customer': customerId,
        },
        url: ApiEndPoints.ephemeral,
        token: ApiKeys.secretKey,
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Stripe-Version': '2025-02-24.acacia',
          "Content-Type": "application/x-www-form-urlencoded",
        });
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    if (!jsonResponse.containsKey('id') || jsonResponse['id'] == null) {
      throw Exception(
          'Stripe API response missing client_secret: $jsonResponse');
    }

    return EphemeralKeyModel.fromJson(jsonResponse);
  }
}
