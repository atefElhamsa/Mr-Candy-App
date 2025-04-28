import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_cubit.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/profile_body.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo_implementation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return BlocProvider(
      create: (context) => ProfileCubit(
        settingRepo: SettingRepoImplementation(),
      )..fetchProfile(),
      child: Directionality(
        textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90.h,
            leading: const SizedBox(),
            flexibleSpace: AppBarWidget(name: "homeProfile".tr()),
          ),
          body: const ProfileBody(),
        ),
      ),
    );
  }
}
