import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "image": image,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image];
}
