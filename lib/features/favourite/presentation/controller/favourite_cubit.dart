import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/features/favourite/data/model/favourite_model.dart';
import 'package:mr_candy/features/favourite/data/repo/favourite_repo_implementation.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_states.dart';

class FavouriteCubit extends Cubit<FavouritesStates> {
  FavouriteCubit() : super(FavouritesInitialStates());

  final FavouriteRepoImplementation favouriteRepoImplementation =
      FavouriteRepoImplementation();
  List<FavouriteItemModel> favouriteList = [];
  int? loadingIndex;

  Future<void> fetchFavourites() async {
    emit(FavouritesLoadingStates());
    final result = await favouriteRepoImplementation.getFavourite();
    result.fold(
      (l) {
        if (l is NoInternetState) {
          emit(NoInternetState());
        } else {
          emit(FavouritesFailureStates(errorMessage: l.message));
        }
      },
      (r) {
        favouriteList = List.from(r);
        emit(FavouritesSuccessStates(favourites: List.from(favouriteList)));
      },
    );
  }

  Future<void> addFavourite({
    required BuildContext context,
    required int index,
  }) async {
    emit(FavouritesLoadingStates());
    final result = await favouriteRepoImplementation.addFavourite(
      context: context,
      index: index,
    );
    result.fold(
      (l) {
        emit(FavouritesFailureStates(errorMessage: l.message));
      },
      (r) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.green,
            showCloseIcon: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            content: Text(
              "addFav".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.h,
              ),
            ),
          ),
        );
        emit(FavouritesSuccessStates(favourites: List.from(favouriteList)));
      },
    );
  }

  Future<void> deleteFavourite({
    required BuildContext context,
    required int index,
  }) async {
    final result = await favouriteRepoImplementation.deleteFavourite(
      context: context,
      index: index,
    );
    result.fold(
      (l) {
        emit(FavouritesFailureStates(errorMessage: l.message));
      },
      (r) {
        emit(FavouritesLoadingStates());
        favouriteList.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.red,
            showCloseIcon: true,
            duration: const Duration(seconds: 1),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            behavior: SnackBarBehavior.floating,
            content: Text(
              "delFav".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.h,
              ),
            ),
          ),
        );
        emit(FavouritesSuccessStates(favourites: List.from(favouriteList)));
      },
    );
  }
}
