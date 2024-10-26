import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/custom_appbar.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/shared_widgets/custom_field.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/sign_up/data/models/sign_up_model.dart';
import 'package:mr_candy/features/sign_up/presentation/controller/sign_up_cubit.dart';
import 'package:mr_candy/features/sign_up/presentation/controller/sign_up_states.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  var formKey = GlobalKey<FormState>();
  var passwordNode = FocusNode();
  var emailNode = FocusNode();
  var phoneNode = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          colors: [
            AppColors.loginAppbar1,
            AppColors.loginAppbar2,
            AppColors.loginAppbar3,
          ],
        ),
      ),
      child: Column(
        children: [
          const CustomAppbar(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    MediaQuery.of(context).size.width * 0.15,
                  ),
                  topRight: Radius.circular(
                    MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
                color: AppColors.white,
              ),
              child: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<SignUpCubit, SignUpStates>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<SignUpCubit>(context)
                                      .pickImageProfile();
                                },
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.2,
                                  backgroundColor: AppColors.transparent,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.24,
                                      ),
                                      border: Border.all(
                                        color: AppColors.iconsFormFieldColor,
                                      ),
                                    ),
                                    child: BlocProvider.of<SignUpCubit>(context)
                                                .image ==
                                            null
                                        ? Icon(
                                            Icons.add_a_photo,
                                            color:
                                                AppColors.iconsFormFieldColor,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23,
                                            ),
                                            child: Image.file(
                                              File(
                                                BlocProvider.of<SignUpCubit>(
                                                        context)
                                                    .image!
                                                    .path,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          BlocBuilder<SignUpCubit, SignUpStates>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: () {
                                  BlocProvider.of<SignUpCubit>(context)
                                      .pickImageProfile();
                                },
                                child: Text(
                                  BlocProvider.of<SignUpCubit>(context).image ==
                                          null
                                      ? AppTexts.addPhoto
                                      : AppTexts.updatePhoto,
                                  style: GoogleFonts.almarai(
                                    textStyle: TextStyle(
                                      color: AppColors.iconsFormFieldColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          CustomField(
                            keyboardType: TextInputType.name,
                            hintTitle: AppTexts.textLabelName,
                            iconData: Icons.person_outline_outlined,
                            errorMessage: AppTexts.errorName,
                            controller: nameController,
                            onFieldSubmitted: (p0) {
                              FocusScope.of(context).requestFocus(
                                emailNode,
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          CustomField(
                            keyboardType: TextInputType.emailAddress,
                            hintTitle: AppTexts.textLabelEmail,
                            iconData: Icons.email_outlined,
                            errorMessage: AppTexts.errorEmail,
                            controller: emailController,
                            focusNode: emailNode,
                            onFieldSubmitted: (p0) {
                              FocusScope.of(context).requestFocus(
                                phoneNode,
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          CustomField(
                            keyboardType: TextInputType.phone,
                            hintTitle: AppTexts.textLabelPhone,
                            iconData: Icons.phone_in_talk_rounded,
                            errorMessage: AppTexts.errorPhone,
                            controller: phoneController,
                            focusNode: phoneNode,
                            onFieldSubmitted: (p0) {
                              FocusScope.of(context).requestFocus(
                                passwordNode,
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          CustomField(
                            keyboardType: TextInputType.visiblePassword,
                            hintTitle: AppTexts.textLabelPassword,
                            iconData: Icons.lock_outline_rounded,
                            errorMessage: AppTexts.errorPassword,
                            controller: passwordController,
                            focusNode: passwordNode,
                            onFieldSubmitted: (p0) {
                              FocusScope.of(context).requestFocus(
                                FocusNode(),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          BlocConsumer<SignUpCubit,SignUpStates>(
                            listener: (context, state) {
                              if (state is SignUpFailureStates) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.errorMessage),
                                    backgroundColor: AppColors.red,
                                    behavior: SnackBarBehavior.floating,
                                    showCloseIcon: true,
                                  ),
                                );
                              } else if (state is SignUpSuccessStates) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(AppTexts.signUpSuccess),
                                    backgroundColor: AppColors.green,
                                    behavior: SnackBarBehavior.floating,
                                    showCloseIcon: true,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return state is SignUpLoadingStates
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      titleButton: AppTexts.signUp,
                                      onTap: () {
                                        if (formKey.currentState!.validate() ==
                                                true &&
                                            BlocProvider.of<SignUpCubit>(
                                                        context)
                                                    .imageToBase64 !=
                                                null) {
                                          FocusScope.of(context).requestFocus(
                                            FocusNode(),
                                          );
                                          BlocProvider.of<SignUpCubit>(context)
                                              .signUp(
                                            userSignUpModel: UserSignUpModel(
                                              name: nameController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              phone:
                                                  phoneController.text.trim(),
                                              password: passwordController.text
                                                  .trim(),
                                              image:
                                                  BlocProvider.of<SignUpCubit>(
                                                          context)
                                                      .imageToBase64!,
                                            ),
                                          );
                                        }
                                      },
                                    );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppTexts.signUpAccount,
                                  style: GoogleFonts.almarai(
                                    textStyle: TextStyle(
                                      color: AppColors.dontHaveAnAccount,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.018,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                AppTexts.haveAccount,
                                style: GoogleFonts.almarai(
                                  textStyle: TextStyle(
                                    color: AppColors.dontHaveAnAccount,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
