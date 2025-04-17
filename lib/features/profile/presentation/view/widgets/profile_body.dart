import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_cubit.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_state.dart';
import 'package:mr_candy/features/profile/presentation/view/edit_profile.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/profile_avatar.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/profile_info_tile.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
        textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileFailureState) {
              return Center(
                child: Text(
                  "Error: ${state.errorMessage}",
                  style: const TextStyle(color: AppColors.red),
                ),
              );
            } else if (state is ProfileSuccessState) {
              final profile = state.profile;
              return Column(
                children: [
                  const SizedBox(height: 30),
                  ProfileAvatar(
                    backgroundImage: NetworkImage(profile.image),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ProfileInfoTile(
                    icon: Icons.email,
                    text: profile.email,
                    iconColor: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  ProfileInfoTile(
                    icon: Icons.phone,
                    text: profile.phone,
                    iconColor: Colors.green,
                  ),
                  const SizedBox(height: 150),
                  CustomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(profile: profile),
                        ),
                      );
                    },
                    titleButton: "homeEditProfile".tr(),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
