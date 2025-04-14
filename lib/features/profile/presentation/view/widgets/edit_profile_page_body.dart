import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/app_bar_widget.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/presentation/views/home_bottom_screen.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_cubit.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_state.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/profile_avatar.dart';

import '../../../data/model/profile_model.dart';
import 'custom_text_form_field.dart';

class EditProfilePageBody extends StatefulWidget {
  final ProfileModel profile;
  const EditProfilePageBody({super.key, required this.profile});

  @override
  State<EditProfilePageBody> createState() => _EditProfilePageBodyState();
}

class _EditProfilePageBodyState extends State<EditProfilePageBody> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String? uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    emailController = TextEditingController(text: widget.profile.email);
    phoneController = TextEditingController(text: widget.profile.phone);
    uploadedImageUrl = widget.profile.image;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    uploadedImageUrl?.toString();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is EditProfileSuccessState) {
          IconSnackBar.show(
            context,
            label: state.message,
            snackBarType: SnackBarType.alert,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: AppColors.green,
            iconColor: AppColors.white,
            maxLines: 2,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeBottomScreen(),
            ),
          );
        } else if (state is EditProfileFailureState) {
          IconSnackBar.show(
            context,
            snackBarType: SnackBarType.alert,
            label: state.errorMessage,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: AppColors.red,
            iconColor: AppColors.white,
            maxLines: 2,
          );
        } else if (state is EditProfileImageUploadedState) {
          setState(() {
            uploadedImageUrl = state.imageUrl;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90.h,
          leading: const SizedBox(),
          flexibleSpace: const AppBarWidget(name: AppTexts.homeEditProfile),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ProfileCubit>().choosePhoto();
                },
                child: ProfileAvatar(
                  backgroundImage: uploadedImageUrl != null &&
                          uploadedImageUrl!.isNotEmpty
                      ? (uploadedImageUrl!.startsWith("http")
                          ? NetworkImage(uploadedImageUrl!)
                          : FileImage(File(uploadedImageUrl!)) as ImageProvider)
                      : const AssetImage(""),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: nameController,
                hintText: "Name",
                keyboardType: TextInputType.text,
                suffixIcon: null,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                suffixIcon: null,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: phoneController,
                hintText: "Phone",
                keyboardType: TextInputType.phone,
                suffixIcon: null,
              ),
              const Spacer(),
              BlocBuilder<ProfileCubit, ProfileStates>(
                builder: (context, state) {
                  return CustomButton(
                    onTap: state is EditProfileLoadingState
                        ? null
                        : () {
                            context.read<ProfileCubit>().editProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: "",
                                  phone: phoneController.text,
                                  image: uploadedImageUrl ?? "",
                                );
                          },
                    titleButton: state is EditProfileLoadingState
                        ? AppTexts.saveChange
                        : AppTexts.save,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
