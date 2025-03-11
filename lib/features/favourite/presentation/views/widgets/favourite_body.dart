import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_states.dart';

import '../../../../../core/utils/app_colors.dart';

class FavouriteBody extends StatefulWidget {
  const FavouriteBody({super.key});

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteCubit>().fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouritesStates>(
      builder: (context, state) {
        if (state is FavouritesLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavouritesFailureStates) {
          return FailureWidget(errorMessage: state.errorMessage);
        } else if (state is FavouritesSuccessStates) {
          final favouriteList = state.favourites;
          return favouriteList.isEmpty
              ? const Center(
                  child: Text("No Favorites Found"),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          10.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.bestSellerColorContainer,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              BlocProvider.of<FavouriteCubit>(
                                                      context)
                                                  .deleteFavourite(
                                                context: context,
                                                index: index,
                                              );
                                              favouriteList[index]
                                                  .productModel
                                                  .inFavorites = false;
                                            });
                                          },
                                          icon: Icon(
                                            favouriteList[index]
                                                    .productModel
                                                    .inFavorites
                                                ? Icons.favorite_outlined
                                                : Icons.favorite_border_rounded,
                                            color: AppColors.loginAppbar1,
                                            size: 20.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 13.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonColor2,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        "-${favouriteList[index].productModel.discount}%",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      favouriteList[index].productModel.image,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1,
                                  errorWidget: (c, u, e) {
                                    return const Icon(
                                        Icons.error_outline_rounded);
                                  },
                                  placeholder: (c, e) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          1.verticalSpace,
                          SizedBox(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 19.w),
                                      child: Text(
                                        favouriteList[index]
                                            .productModel
                                            .name
                                            .substring(0, 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.almarai(
                                          textStyle: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 40.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            maxLines: 1,
                                            favouriteList[index]
                                                .productModel
                                                .price
                                                .toString(),
                                            style: GoogleFonts.almarai(
                                              textStyle: TextStyle(
                                                color: AppColors.loginAppbar1,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            maxLines: 1,
                                            "جنيه",
                                            style: GoogleFonts.almarai(
                                              textStyle: TextStyle(
                                                color: AppColors.loginAppbar1,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.w, bottom: 12.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.buttonColor2,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: favouriteList.length,
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
