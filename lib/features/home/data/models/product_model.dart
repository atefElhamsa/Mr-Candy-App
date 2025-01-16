class ProductModel {
  final int id;
  final num price;
  final num oldPrice;
  final num discount;
  final String name;
  final String image;
  final String description;
  bool inFavorites;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.inFavorites,
    required this.inCart,
    required this.description,
    required this.image,
  });
}
