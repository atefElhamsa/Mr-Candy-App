import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting_state.dart';

import '../../data/model/setting_item_model.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingInitialState());

  void loadSettings(BuildContext context) {
    final List<SettingItemModel> accountSettings = [
      SettingItemModel(
        title: AppTexts.homeProfile,
        leadingIcon: CupertinoIcons.profile_circled,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProfilePage(),
          //   ),
          // );
        },
      ),
      SettingItemModel(
        title: AppTexts.homeChangePassword,
        leadingIcon: Icons.lock_outline,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ChangePasswordScreen(),
          //   ),
          // );
        },
      ),
      SettingItemModel(
        title: AppTexts.homeSettingPrivacy,
        leadingIcon: Icons.privacy_tip_outlined,
        onTap: () {},
      ),
    ];

    final List<SettingItemModel> appSettings = [
      SettingItemModel(
        title: AppTexts.notifications,
        leadingIcon: Icons.notifications,
        onTap: () {},
      ),
      SettingItemModel(
        title: AppTexts.language,
        leadingIcon: Icons.language,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LanguagePage(),
          //   ),
          // );
        },
      ),
      SettingItemModel(
        title: AppTexts.themes,
        leadingIcon: Icons.color_lens,
        onTap: () {},
      ),
    ];

    emit(
      SettingLoadedState(
        accountSettings: accountSettings,
        appSettings: appSettings,
      ),
    );
  }
}
