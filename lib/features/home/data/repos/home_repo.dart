import 'package:dartz/dartz.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BannerModel>>> getBanners();
}
