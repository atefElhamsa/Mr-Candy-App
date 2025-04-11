import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import 'package:mr_candy/features/home/data/repos/home_repo_implementation.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_cubit.dart';
import 'package:mr_candy/features/home/presentation/views/widgets/category_details_list.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({
    super.key,
    required this.title,
    required this.id,
  });

  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.h,
        leading: const SizedBox(),
        flexibleSpace: AppBarWidget(name: title),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CategoryDetailsCubit(homeRepo: HomeRepoImplementation()),
          ),
          BlocProvider(
            create: (context) => FavouriteCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
        ],
        child: CategoryDetailsList(id: id),
      ),
    );
  }
}