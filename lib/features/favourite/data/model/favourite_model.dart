import 'package:equatable/equatable.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

class FavouriteItemModel extends Equatable {
  final int id;
  final ProductModel productModel;

  const FavouriteItemModel({
    required this.id,
    required this.productModel,
  });

  factory FavouriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavouriteItemModel(
      id: json['id'] ?? 0,
      productModel: ProductModel.fromJson(json['product'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': productModel.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, productModel];
}
