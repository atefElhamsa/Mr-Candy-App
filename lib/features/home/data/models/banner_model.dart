import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final String image;
  final int id;

  const BannerModel({
    required this.image,
    required this.id,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image,id];
}
