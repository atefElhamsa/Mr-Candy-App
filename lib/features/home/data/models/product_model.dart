import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String name;
  final String image;
  final String description;
  final List<String> images;
  bool inFavorites;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    this.inFavorites = false,
    this.inCart = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int
          ? json['id']
          : (json['id'] as double?)?.toInt() ?? 0,
      price: json['price'] is int
          ? json['price']
          : (json['price'] as double?)?.toInt() ?? 0,
      oldPrice: json['old_price'] is int
          ? json['old_price']
          : (json['old_price'] as double?)?.toInt() ?? 0,
      discount: json['discount'] is int
          ? json['discount']
          : (json['discount'] as double?)?.toInt() ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      inFavorites: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
      images: json['images'] != null && json['images'] is List
          ? List<String>.from(json['images'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'in_favorites': inFavorites,
      'in_cart': inCart,
      'images': images,
    };
  }

  @override
  List<Object?> get props => [
        id,
        price,
        oldPrice,
        discount,
        name,
        image,
        description,
        inFavorites,
        inCart,
        images,
      ];
}
