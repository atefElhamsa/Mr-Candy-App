import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/category_details/presentation/view/widgets/show_category_widget.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

class ShowCategoryScreen extends StatelessWidget {
  final ProductModel productModel;
  const ShowCategoryScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: AppBarWidget(name: "categoryDetail".tr()),
        ),
        body: ShowCategoryWidget(
          productModel: productModel,
        ),
      ),
    );
  }
}
