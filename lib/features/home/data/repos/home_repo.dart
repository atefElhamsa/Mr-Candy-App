import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';
import 'package:mr_candy/features/home/data/models/category_model.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerModel>>> getBanners();
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<ProductModel>>> getBestSellerProducts();
}
