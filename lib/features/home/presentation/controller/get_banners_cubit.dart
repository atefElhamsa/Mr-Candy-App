import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/home/data/repos/home_repo.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_states.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit({required this.homeRepo}) : super(BannersInitialStates());
  final HomeRepo homeRepo;
  Future<void> getBanners() async {
    emit(BannersLoadingStates());
    var result = await homeRepo.getBanners();
    result.fold(
      (l) {
        emit(BannersFailureStates(errorMessage: l.message));
      },
      (r) {
        emit(BannersSuccessStates(banners: r));
      },
    );
  }
}
