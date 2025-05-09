import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/failure_widget.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_cubit.dart';
import 'package:mr_candy/features/home/presentation/controller/get_banners_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersStates>(
      builder: (context, state) {
        if (state is BannersLoadingStates) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BannersFailureStates) {
          return FailureWidget(
            errorMessage: state.errorMessage,
            onPressed: () {
              context.read<BannersCubit>().getBanners();
            },
          );
        } else if (state is BannersSuccessStates) {
          final banners = BlocProvider.of<BannersCubit>(context).banners;
          return banners.isEmpty
              ? Center(
                  child: Text(
                    AppTexts.noBannersAvailable,
                    style: GoogleFonts.cairo(
                      color: AppColors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.loginAppbar1,
                            AppColors.navBar,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.splashImage,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.13,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            child: CarouselSlider(
                              items: banners.map(
                                (e) {
                                  return CachedNetworkImage(
                                    imageUrl: e.image,
                                    errorWidget: (c, u, e) {
                                      return const Icon(
                                          Icons.error_outline_rounded);
                                    },
                                    placeholder: (c, e) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                              options: CarouselOptions(
                                viewportFraction: 0.8,
                                initialPage: currentIndex,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                onPageChanged: (index, reason) {
                                  currentIndex = index;
                                  setState(() {});
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.sizeOf(context).height * 0.43,
                      child: SmoothPageIndicator(
                        controller: PageController(
                          initialPage: currentIndex,
                        ),
                        count: banners.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: MediaQuery.sizeOf(context).height * 0.01,
                          dotWidth: MediaQuery.sizeOf(context).width * 0.03,
                          activeDotColor: AppColors.activeSmooth,
                          dotColor: AppColors.grey,
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
