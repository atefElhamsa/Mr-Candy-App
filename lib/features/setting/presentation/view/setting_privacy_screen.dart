import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/extensions/app_information_service.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_text_privacy.dart';
import '../../../../core/shared_widgets/app_bar_widget.dart';

class SettingPrivacyScreen extends StatelessWidget {
  const SettingPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: AppBarWidget(name: "homeSettingPrivacy".tr()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection:
                isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
            children: [
              CustomTextPrivacy(
                title: "name",
                info: AppInfoHelper().appName,
              ),
              CustomTextPrivacy(
                title: "version",
                info: AppInfoHelper().version,
              ),
              CustomTextPrivacy(
                title: "buildNumber",
                info: AppInfoHelper().buildNumber,
              ),
              CustomTextPrivacy(
                title: "packageName",
                info: AppInfoHelper().packageName,
              ),
              CustomTextPrivacy(
                title: "updateTime",
                info: AppInfoHelper().updateTime.toString().substring(0, 10),
              ),
              CustomTextPrivacy(
                title: "installTime",
                info: AppInfoHelper().installTime.toString().substring(0, 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
