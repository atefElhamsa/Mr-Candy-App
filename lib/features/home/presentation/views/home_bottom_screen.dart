import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/favourite/presentation/views/favourite_screen.dart';
import 'package:mr_candy/features/home/presentation/views/home_main_screen.dart';
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
    const Icon(Icons.add_shopping_cart),
    const Icon(Icons.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                  title: const Text(AppTexts.homeMain),
                ),
                SalomonBottomBarItem(
                  icon: Icon(CupertinoIcons.heart, size: 25.sp),
                  title: const Text(AppTexts.homeFav),
                ),
                SalomonBottomBarItem(
                  icon: Icon(CupertinoIcons.bag, size: 25.sp),
                  title: const Text(AppTexts.homeCarts),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.settings, size: 25.sp),
                  title: const Text(AppTexts.homeSetting),
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
