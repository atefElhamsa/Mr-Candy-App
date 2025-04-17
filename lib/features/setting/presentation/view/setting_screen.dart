import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/features/setting/presentation/controller/language/language_cubit.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting/setting_cubit.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_list_view_account_setting.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_list_view_app_setting.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_setting_title.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // context.setLocale(const Locale('en', 'US'));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingCubit()..loadSettings(context),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: AppBarWidgetWithoutBack(
            name: context.tr("homeSetting"),
          ),
        ),
        body: Column(
          children: [
            CustomSettingTitle(title: "homeSettingSubTitle".tr()),
            CustomListViewAccountSetting(),
            CustomSettingTitle(title: "homeAppSettingSubTitle".tr()),
            CustomListViewAppSetting(),
          ],
        ),
      ),
    );
  }
}
