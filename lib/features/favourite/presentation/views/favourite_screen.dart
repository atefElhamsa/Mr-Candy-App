import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import 'package:mr_candy/features/favourite/presentation/views/widgets/favourite_body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: const AppBarWidgetWithoutBack(name: AppTexts.homeFav),
      ),
      body: BlocProvider(
        create: (context) => FavouriteCubit()..fetchFavourites(),
        child: const FavouriteBody(),
      ),
    );
  }
}
