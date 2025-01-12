import 'package:mr_candy/features/home/data/models/banner_model.dart';

abstract class BannersStates {}

class BannersInitialStates extends BannersStates {}

class BannersLoadingStates extends BannersStates {}

class BannersFailureStates extends BannersStates {
  final String errorMessage;

  BannersFailureStates({required this.errorMessage});
}

class BannersSuccessStates extends BannersStates {
  final List<BannerModel> banners;

  BannersSuccessStates({required this.banners});
}
