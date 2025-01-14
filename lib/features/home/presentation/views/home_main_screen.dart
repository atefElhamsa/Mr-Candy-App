import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_cubit.dart';
import 'package:mr_candy/features/home/presentation/views/widgets/banner_widget.dart';
import 'package:mr_candy/features/home/presentation/views/widgets/categories_list.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        context.read<BannersCubit>().getBanners(),
        context.read<CategoriesCubit>().getCategories(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const BannerWidget(),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
          ),
          child: Text(
            AppTexts.products,
            style: GoogleFonts.almarai(
              textStyle: TextStyle(
                color: AppColors.loginAppbar1,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.sizeOf(context).height * 0.03,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
          ),
          child: const CategoriesList(),
        ),
      ],
    );
  }
}
