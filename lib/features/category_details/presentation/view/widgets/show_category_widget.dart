import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/home/data/models/product_model.dart';

class ShowCategoryWidget extends StatefulWidget {
  final ProductModel productModel;
  int index;
  ShowCategoryWidget({super.key, required this.productModel, required this.index});

  @override
  State<ShowCategoryWidget> createState() => _ShowCategoryWidgetState();
}

class _ShowCategoryWidgetState extends State<ShowCategoryWidget> {
  int selectedImageIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Container(
                height: 200.h,
                width: 300.w,
                decoration: const BoxDecoration(),
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      selectedImageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.productModel.images[index],
                      errorWidget: (c, u, e) {
                        return const Icon(Icons.error_outline_rounded);
                      },
                      placeholder: (c, e) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 80.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.productModel.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImageIndex = index;
                        pageController.jumpToPage(index);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        height: 80.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selectedImageIndex == index
                                ? AppColors.loginAppbar3
                                : AppColors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.productModel.images[index],
                          fit: BoxFit.fitHeight,
                          placeholder: (c, e) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorWidget: (c, u, e) {
                            return const Icon(Icons.error_outline_rounded);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            const Divider(
              color: AppColors.grey,
              thickness: 2.0,
            ),
            Text(
              widget.productModel.name,
              maxLines: 5,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "السعر: ${widget.productModel.price}",
              maxLines: 5,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.green,
                fontSize: 20.h,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "%الخصم: ${widget.productModel.discount}",
              maxLines: 5,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.red,
                fontSize: 20.h,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              widget.productModel.description,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              titleButton: AppTexts.addCart,
              onTap: () {
                BlocProvider.of<CartCubit>(context).addCart(context, widget.index);
              },
            )
          ],
        ),
      ),
    );
  }
}
