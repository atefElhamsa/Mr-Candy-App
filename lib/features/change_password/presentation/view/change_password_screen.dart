import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/change_password/presentation/controller/change_password_cubit.dart';
import 'package:mr_candy/features/change_password/presentation/view/widgets/change_password_body.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo_implementation.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(settingRepo: SettingRepoImplementation()),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: const AppBarWidget(name: AppTexts.homeChangePassword),
        ),
        body: const ChangePasswordBody(),
      ),
    );
  }
}
