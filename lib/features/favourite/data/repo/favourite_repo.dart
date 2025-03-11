import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/favourite/data/model/favourite_model.dart';

abstract class FavouriteRepo {
  Future<Either<Failure, List<FavouriteItemModel>>> getFavourite();
  Future<Either<Failure, void>> deleteFavourite({
    required BuildContext context,
    required int index,
  });
  Future<Either<Failure, void>> addFavourite({
    required BuildContext context,
    required int index,
  });
}
