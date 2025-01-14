import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_categories_states.dart';
import '../../../../../core/utils/app_colors.dart';

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
          );
        } else if (state is CategoriesSuccessStates) {
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            spacing: MediaQuery.sizeOf(context).width * 0.02,
            runSpacing: MediaQuery.sizeOf(context).height * 0.01,
            children: [
              ...state.categories.map(
                (e) => Container(
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
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        errorWidget: (c, u, e) {
                          return const Icon(Icons.error_outline_rounded);
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
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
