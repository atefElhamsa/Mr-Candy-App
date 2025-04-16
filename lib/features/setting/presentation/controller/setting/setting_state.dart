import 'package:mr_candy/features/setting/data/model/setting_item_model.dart';

abstract class SettingStates {}

class SettingInitialState extends SettingStates {}

class SettingLoadedState extends SettingStates {
  final List<SettingItemModel> accountSettings;
  final List<SettingItemModel> appSettings;

  SettingLoadedState({
    required this.accountSettings,
    required this.appSettings,
  });
}
