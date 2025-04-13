import 'package:flutter/material.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_list_view_account_setting.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_list_view_app_setting.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_setting_title.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomSettingTitle(title: AppTexts.homeSettingSubTitle),
        CustomListViewAccountSetting(),
        CustomSettingTitle(title: AppTexts.homeAppSettingSubTitle),
        CustomListViewAppSetting(),
      ],
    );
  }
}
