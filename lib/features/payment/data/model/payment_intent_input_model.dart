class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  Map<String, dynamic> toJson() {
    final dividedAmount = (double.parse(amount) / 50).round();
    return {
      'amount': "${dividedAmount}00",
      'currency': currency,
      'customer': customerId
    };
  }
}
