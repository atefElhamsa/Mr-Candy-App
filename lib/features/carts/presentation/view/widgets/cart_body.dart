import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_candy/core/extensions/notification_service.dart';
import 'package:mr_candy/core/shared_widgets/custom_awesome_dialog.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_cubit.dart';
import 'package:mr_candy/features/carts/presentation/controller/cart_states.dart';
import 'package:mr_candy/features/carts/presentation/view/widgets/payment_method_bottom_sheet.dart';
import 'package:mr_candy/features/payment/data/repo/checkout_repo_implementaion.dart';
import 'package:mr_candy/features/payment/presentation/controller/payment_cubit.dart';
import '../../../../../core/shared_widgets/failure_widget.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  bool isLoading = false;
  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    setState(() => isLoading = true);
    await context.read<CartCubit>().fetchCarts();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        if (state is CartLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CartFailureState) {
          return Center(
            child: FailureWidget(
              errorMessage: state.errorMessage,
              onPressed: () {
                context.read<CartCubit>().fetchCarts();
              },
            ),
          );
        } else if (state is CartSuccessState) {
          final cartItems = state.cartList;
          num sum() {
            totalPrice = 0;
            for (int i = 0; i < cartItems.length; i++) {
              totalPrice +=
                  cartItems[i].quantity * cartItems[i].productModel.price;
            }
            return totalPrice;
          }

          return cartItems.isEmpty
              ? Center(
                  child: Lottie.asset(
                    AppImages.emptyDataAnimation,
                    height: 400.h,
                    width: 400.w,
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.r),
                                height: 200.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: isArabic
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          CustomAwesomeDialog()
                                              .showCustomDialog(
                                            context: context,
                                            title: "delete",
                                            desc: "sureDeleteOneProduct",
                                            btnOkOnPress: () {
                                              NotificationService()
                                                  .saveNotifications(
                                                body: "delFromCart".tr(),
                                                title: cartItems[index]
                                                    .productModel
                                                    .name,
                                                id: cartItems[index].id,
                                              );
                                              BlocProvider.of<CartCubit>(
                                                      context)
                                                  .deleteCart(context, index);
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.red,
                                            borderRadius: isArabic
                                                ? BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.r),
                                                    bottomLeft:
                                                        Radius.circular(20.r),
                                                  )
                                                : BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.r),
                                                    bottomRight:
                                                        Radius.circular(20.r),
                                                  ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "delete".tr(),
                                              style: GoogleFonts.cairo(
                                                fontSize: 15.sp,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: isArabic
                                          ? EdgeInsets.only(
                                              right: 45.w,
                                              left: 150.w,
                                            )
                                          : EdgeInsets.only(
                                              right: 150.w,
                                              left: 45.w,
                                            ),
                                      child: Text(
                                        cartItems[index].productModel.name,
                                        maxLines: 1,
                                        style: GoogleFonts.cairo(
                                          fontSize: 30.h,
                                          color: AppColors.loginAppbar3,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: isArabic
                                          ? EdgeInsets.only(right: 44.w)
                                          : EdgeInsets.only(left: 44.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            "quantity".tr(),
                                            style: GoogleFonts.cairo(
                                              fontSize: 30.h,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${cartItems[index].quantity}",
                                            style: GoogleFonts.cairo(
                                              fontSize: 30.h,
                                              color: AppColors.loginAppbar3,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: isArabic
                                          ? EdgeInsets.only(right: 44.w)
                                          : EdgeInsets.only(left: 44.w),
                                      child: Row(
                                        children: [
                                          Text(
                                            "totalPrice".tr(),
                                            style: GoogleFonts.cairo(
                                              fontSize: 30.h,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${cartItems[index].productModel.price * cartItems[index].quantity}${"pound".tr()}",
                                            style: GoogleFonts.cairo(
                                              fontSize: 30.h,
                                              color: AppColors.loginAppbar3,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: Row(
                                        spacing: 20.w,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                cartItems[index] =
                                                    cartItems[index].copyWith(
                                                  quantity: cartItems[index]
                                                          .quantity +
                                                      1,
                                                );
                                                totalPrice = 0;
                                              });
                                            },
                                            child: Container(
                                              height: 35.h,
                                              width: 35.w,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.green,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColors.white,
                                                  size: 25.h,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${cartItems[index].quantity}",
                                            style: GoogleFonts.cairo(
                                              fontSize: 23.sp,
                                              color: AppColors.loginAppbar3,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (cartItems[index].quantity >=
                                                    1) {
                                                  cartItems[index] =
                                                      cartItems[index].copyWith(
                                                    quantity: cartItems[index]
                                                            .quantity -
                                                        1,
                                                  );
                                                } else if (cartItems[index]
                                                        .quantity <=
                                                    0) {
                                                  cartItems[index] =
                                                      cartItems[index].copyWith(
                                                          quantity: 0);
                                                }
                                                totalPrice = 0;
                                              });
                                            },
                                            child: Container(
                                              height: 35.h,
                                              width: 35.w,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.red,
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: AppColors.white,
                                                size: 25.h,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 30.h,
                                right: isArabic ? 250.w : 10.w,
                                child: CachedNetworkImage(
                                  imageUrl: cartItems[index].productModel.image,
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
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 5.h,
                          );
                        },
                        itemCount: cartItems.length,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.r),
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                      ),
                      height: 70.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: AppColors.loginAppbar3,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "totalPrice".tr(),
                            style: GoogleFonts.cairo(
                              fontSize: 30.h,
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${sum()}${"pound".tr()}",
                            style: GoogleFonts.cairo(
                              fontSize: 30.h,
                              color: AppColors.loginAppbar3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          titleButton: "sure".tr(),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => PaymentCubit(
                                    CheckOutRepoImplementation(),
                                  ),
                                  child: PaymentMethodBottomSheet(
                                    isLoading: isLoading,
                                    totalPrice: totalPrice,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
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
