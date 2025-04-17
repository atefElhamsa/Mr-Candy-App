import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/features/carts/presentation/view/cart_screen.dart';
import 'package:mr_candy/features/favourite/presentation/views/favourite_screen.dart';
import 'package:mr_candy/features/home/presentation/views/home_main_screen.dart';
import 'package:mr_candy/features/setting/presentation/view/setting_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeBottomScreen extends StatefulWidget {
  const HomeBottomScreen({super.key});

  @override
  State<HomeBottomScreen> createState() => _HomeBottomScreenState();
}

class _HomeBottomScreenState extends State<HomeBottomScreen> {
  int currentIndex = 0;
  List screens = [
    const HomeMainScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 75.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MediaQuery.sizeOf(context).width * 0.08),
              topRight: Radius.circular(MediaQuery.sizeOf(context).width * 0.08),
            ),
            child: SalomonBottomBar(
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.grey,
              backgroundColor: AppColors.navBar,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                SalomonBottomBarItem(
                  icon: Icon(CupertinoIcons.house_fill, size: 25.sp),
                  title: Text("homeMain".tr()),
                ),
                SalomonBottomBarItem(
                  icon: Icon(CupertinoIcons.heart, size: 25.sp),
                  title: Text("homeFav".tr()),
                ),
                SalomonBottomBarItem(
                  icon: Icon(CupertinoIcons.bag, size: 25.sp),
                  title: Text("homeCarts".tr()),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.settings, size: 25.sp),
                  title: Text("homeSetting".tr()),
                ),
              ],
            ),
          ),
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
