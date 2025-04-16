import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

class BestSellerWidget extends StatefulWidget {
  const BestSellerWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: AppColors.loginAppbar1,
                        size: 20.h,
                      ),
                    ),
                  ),
                  70.horizontalSpace,
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
                      "${widget.productModel.discount}-",
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
                imageUrl: widget.productModel.image,
                width: 120.w,
                height: 120.h,
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
        5.verticalSpace,
        SizedBox(
          child: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35.w),
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
                    padding: EdgeInsets.only(left: 40.w),
                    child: Text(
                      "${widget.productModel.price}${AppTexts.pound}",
                      maxLines: 1,
                      style: GoogleFonts.almarai(
                          color: AppColors.loginAppbar1,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
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
    );
  }
}
