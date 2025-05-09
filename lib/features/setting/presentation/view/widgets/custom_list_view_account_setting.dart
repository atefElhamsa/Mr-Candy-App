import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting/setting_cubit.dart';
import 'package:mr_candy/features/setting/presentation/controller/setting/setting_state.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/share_list_tile.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomListViewAccountSetting extends StatefulWidget {
  const CustomListViewAccountSetting({super.key});

  @override
  State<CustomListViewAccountSetting> createState() => _CustomListViewAccountSettingState();
}

class _CustomListViewAccountSettingState extends State<CustomListViewAccountSetting> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingStates>(
      builder: (context, state) {
        if (state is SettingInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SettingLoadedState) {
          final settings = state.accountSettings;
          return Expanded(
            flex: 2,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = settings[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ShareListTile(
                    title: Text(
                      item.title.tr(),
                      style: GoogleFonts.almarai(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.loginAppbar2,
                      ),
                    ),
                    leading: Icon(
                      item.leadingIcon,
                      size: 25.sp,
                      color: AppColors.loginAppbar3,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.loginAppbar3,
                    ),
                    onTap: item.onTap,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: settings.length,
            ),
          );
        } else {
          return Center(
            child: Text(
              AppTexts.somethingWentWrong,
              style: GoogleFonts.cairo(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 25.sp,
              ),
            ),
          );
        }
      },
    );
  }
}
