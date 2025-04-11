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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: const AppBarWidget(name: AppTexts.categoryDetail),
      ),
      body: ShowCategoryWidget(
        productModel: productModel,
      ),
    );
  }
}
