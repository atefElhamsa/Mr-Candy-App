import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/data/models/banner_model.dart';
import 'package:mr_candy/features/home/data/repos/home_repo_implementation.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_states.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit() : super(BannersInitialStates());
  final HomeRepoImplementation homeRepo = HomeRepoImplementation();
  List<BannerModel> banners = [];
  Future<void> getBanners() async {
    emit(BannersLoadingStates());
    var result = await homeRepo.getBanners();
    result.fold(
      (l) {
        emit(BannersFailureStates(errorMessage: l.message));
      },
      (r) {
        banners = r;
        emit(BannersSuccessStates(banners: banners));
      },
    );
  }
}
