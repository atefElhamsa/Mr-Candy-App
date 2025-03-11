import 'package:equatable/equatable.dart';
import 'package:mr_candy/features/favourite/data/model/favourite_model.dart';

abstract class FavouritesStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouritesInitialStates extends FavouritesStates {}

class FavouritesLoadingStates extends FavouritesStates {}

class FavouritesFailureStates extends FavouritesStates {
  final String errorMessage;

  FavouritesFailureStates({required this.errorMessage});
}

class FavouritesSuccessStates extends FavouritesStates {
  final List<FavouriteItemModel> favourites;

  FavouritesSuccessStates({required this.favourites});
}

class NoInternetState extends FavouritesStates {}
