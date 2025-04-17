import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_states.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../category_details/presentation/view/category_details_screen.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        if (state is CategoriesLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CategoriesFailureStates) {
          return FailureWidget(
            errorMessage: state.errorMessage,
            onPressed: () {
              BlocProvider.of<CategoriesCubit>(context).getCategories();
            },
          );
        } else if (state is CategoriesSuccessStates) {
          final categoriesList =
              BlocProvider.of<CategoriesCubit>(context).categoriesList;
          return categoriesList.isEmpty
              ? Center(
                  child: Text(
                    "noCategoryAvailable".tr(),
                    style: GoogleFonts.cairo(
                      color: AppColors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: MediaQuery.sizeOf(context).width * 0.02,
                  runSpacing: MediaQuery.sizeOf(context).height * 0.01,
                  children: categoriesList
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return CategoryDetailsScreen(
                                  title: e.name,
                                  id: e.id,
                                );
                              }),
                            );
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(
                                MediaQuery.sizeOf(context).width * 0.05,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: e.image,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  errorWidget: (c, u, e) {
                                    return const Icon(
                                      Icons.error_outline_rounded,
                                    );
                                  },
                                  placeholder: (c, e) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                  e.name,
                                  style: GoogleFonts.almarai(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
        } else {
          return Center(
            child: Text(
              "noExistedData".tr(),
              style: GoogleFonts.almarai(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.h,
              ),
            ),
          );
        }
      },
    );
  }
}
