import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/features/home/data/repos/home_repo_implementation.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_cubit.dart';
import 'package:mr_candy/features/home/presentation/views/widgets/category_details_list.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen(
      {super.key, required this.title, required this.id});

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
      body: BlocProvider(
        create: (context) => CategoryDetailsCubit(homeRepo: HomeRepoImplementation()),
        child: CategoryDetailsList(id: id),
      ),
    );
  }
}
