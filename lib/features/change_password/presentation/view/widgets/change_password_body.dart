import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/features/change_password/presentation/controller/change_password_cubit.dart';
import 'package:mr_candy/features/change_password/presentation/controller/change_password_state.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/custom_text_form_field.dart';
import 'package:mr_candy/features/setting/presentation/view/widgets/custom_setting_title.dart';

import '../../../../../core/utils/app_colors.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  var newPasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
              ),
              backgroundColor: AppColors.loginAppbar3,
              showCloseIcon: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
          _currentPasswordController.clear();
          _newPasswordController.clear();
        } else if (state is ChangePasswordFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.h),
              ),
              backgroundColor: AppColors.loginAppbar3,
              showCloseIcon: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              CustomSettingTitle(
                title: "textLabelCurrentPassword".tr(),
              ),
              CustomTextFormField(
                keyboardType: TextInputType.visiblePassword,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).requestFocus(newPasswordNode);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                  icon: Icon(
                    _obscureCurrentPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                obscureText: _obscureCurrentPassword,
                controller: _currentPasswordController,
              ),
              const SizedBox(height: 30),
              CustomSettingTitle(
                title: "textLabelNewPassword".tr(),
              ),
              CustomTextFormField(
                keyboardType: TextInputType.visiblePassword,
                focusNode: newPasswordNode,
                onFieldSubmitted: (p0) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                  icon: Icon(
                    _obscureNewPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                obscureText: _obscureNewPassword,
                controller: _newPasswordController,
              ),
              const Spacer(),
              Expanded(
                child: Center(
                  child: CustomButton(
                    onTap: state is ChangePasswordLoadingState
                        ? null
                        : () {
                            context.read<ChangePasswordCubit>().changePassword(
                                  currentPassword:
                                      _currentPasswordController.text,
                                  newPassword: _newPasswordController.text,
                                );
                          },
                    titleButton: state is ChangePasswordLoadingState
                        ? "saveChange".tr()
                        : "homeChangePassword".tr(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
