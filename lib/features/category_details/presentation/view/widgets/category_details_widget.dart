import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/favourite/presentation/controller/favourite_cubit.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';
import '../../../../../core/utils/app_colors.dart';

class CategoryDetailsWidget extends StatefulWidget {
  const CategoryDetailsWidget({
    super.key,
    required this.productModel,
    required this.index,
  });

  final ProductModel productModel;
  final int index;

  @override
  State<CategoryDetailsWidget> createState() => _CategoryDetailsWidgetState();
}

class _CategoryDetailsWidgetState extends State<CategoryDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 13.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor2,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "${widget.productModel.discount}%",
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: IconButton(
                        onPressed: () {
                          widget.productModel.inFavorites =
                              !widget.productModel.inFavorites;
                          if (widget.productModel.inFavorites) {
                            BlocProvider.of<FavouriteCubit>(context)
                                .addFavourite(
                              context: context,
                              index: widget.index,
                            );
                          }
                          setState(() {});
                        },
                        icon: widget.productModel.inFavorites == true
                            ? Icon(
                                Icons.favorite_outlined,
                                color: AppColors.loginAppbar1,
                                size: 20.h,
                              )
                            : Icon(
                                Icons.favorite_border_rounded,
                                color: AppColors.loginAppbar1,
                                size: 20.h,
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CachedNetworkImage(
                  imageUrl: widget.productModel.image,
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
              ],
            ),
          ),
          1.verticalSpace,
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CartCubit>(context)
                          .addCart(context, widget.index);
                    },
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
                ),
                Column(
                  children: [
                    Padding(
                      padding: isArabic
                          ? EdgeInsets.only(left: 19.w)
                          : EdgeInsets.only(right: 30.w),
                      child: Text(
                        widget.productModel.name.substring(0, 15),
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
                      padding: isArabic
                          ? EdgeInsets.only(left: 40.w)
                          : EdgeInsets.only(right: 50.w),
                      child: Row(
                        children: [
                          Text(
                            maxLines: 1,
                            "pound".tr(),
                            style: GoogleFonts.almarai(
                              color: AppColors.loginAppbar1,
                              fontWeight: FontWeight.w700,
                              fontSize: 17.sp,
                            ),
                          ),
                          Text(
                            maxLines: 1,
                            widget.productModel.price.toString(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
