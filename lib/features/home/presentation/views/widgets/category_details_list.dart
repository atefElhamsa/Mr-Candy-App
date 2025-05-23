import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/features/category_details/presentation/view/show_category_screen.dart';
import 'package:mr_candy/features/category_details/presentation/view/widgets/category_details_widget.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_category_details_states.dart';

class CategoryDetailsList extends StatefulWidget {
  const CategoryDetailsList({super.key, required this.id});

  final int id;

  @override
  State<CategoryDetailsList> createState() => _CategoryDetailsListState();
}

class _CategoryDetailsListState extends State<CategoryDetailsList> {
  @override
  void initState() {
    super.initState();
    context
        .read<CategoryDetailsCubit>()
        .getCategoryDetails(categoryId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsStates>(
      builder: (context, state) {
        if (state is CategoryDetailsLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CategoryDetailsFailureStates) {
          return Center(
            child: FailureWidget(errorMessage: state.errorMessage),
          );
        } else if (state is CategoryDetailsSuccessStates) {
          var categoriesDetailsList =
              BlocProvider.of<CategoryDetailsCubit>(context).categoryDetails;
          return categoriesDetailsList.isEmpty
              ? Center(
                  child: Text(
                    "noCategoryAvailable".tr(),
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      fontSize: 25.sp,
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShowCategoryScreen(
                                productModel: categoriesDetailsList[index],
                              );
                            },
                          ),
                        );
                      },
                      child: CategoryDetailsWidget(
                        index: index,
                        productModel: categoriesDetailsList[index],
                      ),
                    );
                  },
                  itemCount: categoriesDetailsList.length,
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
