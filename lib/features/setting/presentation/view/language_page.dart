import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/translate.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_best_seller_product_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_cubit.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: AppBarWidget(name: context.changeLanguage),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, left: 5.w, right: 5.w),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 5,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "English",
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Switch(
                  value: isArabic,
                  activeColor: AppColors.loginAppbar3,
                  inactiveThumbColor: AppColors.grey,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (value) {
                    Locale newLocale =
                        value ? const Locale('ar') : const Locale('en');
                    context.setLocale(newLocale);
                    context.read<BestSellerProductsCubit>().getBestSellerProducts();
                    context.read<BannersCubit>().getBanners();
                    context.read<CategoriesCubit>().getCategories();
                    setState(() {});
                  },
                ),
                Text(
                  "العربية",
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
