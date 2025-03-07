import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/presentation/views/home_main_screen.dart';

class HomeBottomScreen extends StatefulWidget {
  const HomeBottomScreen({super.key});

  @override
  State<HomeBottomScreen> createState() => _HomeBottomScreenState();
}

class _HomeBottomScreenState extends State<HomeBottomScreen> {
  int currentIndex = 0;
  List screens = [
    const HomeMainScreen(),
    const Icon(Icons.favorite),
    const Icon(Icons.add_shopping_cart),
    const Icon(Icons.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.09,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MediaQuery.sizeOf(context).width * 0.1),
              topRight: Radius.circular(MediaQuery.sizeOf(context).width * 0.1),
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              elevation: 0,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.white.withOpacity(0.75),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.navBar,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    currentIndex == 0
                        ? AppImages.homeImage
                        : AppImages.homeNotActiveImage,
                  ),
                  label: AppTexts.homeMain,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.favHome),
                  label: AppTexts.homeFav,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    currentIndex == 2
                        ? AppImages.cartsActiveHome
                        : AppImages.cartsHome,
                  ),
                  label: AppTexts.homeCarts,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.settingHome),
                  label: AppTexts.homeSetting,
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
