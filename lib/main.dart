import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/extensions/api_keys.dart';
import 'package:mr_candy/core/extensions/app_information_service.dart';
import 'package:mr_candy/core/extensions/notification_service.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import 'package:mr_candy/features/setting/presentation/controller/language/language_cubit.dart';
import 'package:mr_candy/features/splash/presentation/views/splash_screen.dart';
import 'features/home/presentation/controller/get_banners_cubit.dart';
import 'features/home/presentation/controller/get_best_seller_product_cubit.dart';
import 'features/home/presentation/controller/get_categories_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.publishKey;
  await Hive.initFlutter();
  await Hive.openBox(AppTexts.nameOfBox);
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  NotificationService().initNotification();
  AppInfoHelper().init();
  runApp(
    EasyLocalization(
      path: "assets/translation",
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      fallbackLocale: const Locale('ar'),
      startLocale: Locale(
        WidgetsBinding.instance.platformDispatcher.locale.languageCode,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BannersCubit()..getBanners(),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit()..getCategories(),
          ),
          BlocProvider(
            create: (context) =>
                BestSellerProductsCubit()..getBestSellerProducts(),
          ),
          BlocProvider(
            create: (context) => FavouriteCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        context.read<BannersCubit>().getBanners(),
        context.read<CategoriesCubit>().getCategories(),
        context.read<BestSellerProductsCubit>().getBestSellerProducts(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 1006),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Mr Candy",
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          home: const SplashScreen(),
        );
      },
    );
  }
}
