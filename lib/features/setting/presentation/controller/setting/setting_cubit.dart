import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting/setting_state.dart';

import '../../../../change_password/presentation/view/change_password_screen.dart';
import '../../../../profile/presentation/view/profile_page.dart';
import '../../../data/model/setting_item_model.dart';
import '../../view/language_page.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingInitialState());

  void loadSettings(BuildContext context) {
    final List<SettingItemModel> accountSettings = [
      SettingItemModel(
        title: "homeProfile",
        leadingIcon: CupertinoIcons.profile_circled,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          );
        },
      ),
      SettingItemModel(
        title: "homeChangePassword",
        leadingIcon: Icons.lock_outline,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          );
        },
      ),
      SettingItemModel(
        title: "homeSettingPrivacy",
        leadingIcon: Icons.privacy_tip_outlined,
        onTap: () {},
      ),
    ];

    final List<SettingItemModel> appSettings = [
      SettingItemModel(
        title: "notifications",
        leadingIcon: Icons.notifications,
        onTap: () {},
      ),
      SettingItemModel(
        title: "language",
        leadingIcon: Icons.language,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LanguagePage(),
            ),
          );
        },
      ),
      SettingItemModel(
        title: "themes",
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
