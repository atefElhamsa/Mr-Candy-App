import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting_cubit.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..loadSettings(context),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: const AppBarWidgetWithoutBack(
            name: AppTexts.homeSetting,
          ),
        ),
        body: const SettingBody(),
      ),
    );
  }
}
