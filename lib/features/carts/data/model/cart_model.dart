import 'package:equatable/equatable.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

class CartModel extends Equatable {
  final int id;
  final int quantity;
  final ProductModel productModel;

  const CartModel({
    required this.id,
    required this.quantity,
    required this.productModel,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 1,
      productModel: ProductModel.fromJson(json['product'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': productModel.toJson(),
    };
  }

  CartModel copyWith({int? quantity}) {
    return CartModel(
      id: id,
      quantity: quantity ?? this.quantity,
      productModel: productModel,
    );
  }

  @override
  List<Object?> get props => [id, quantity, productModel];
}
