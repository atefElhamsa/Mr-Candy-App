import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/custom_appbar.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/shared_widgets/custom_field.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/home/presentation/views/home_bottom_screen.dart';
import 'package:mr_candy/features/login/presentation/controller/login_cubit.dart';
import 'package:mr_candy/features/login/presentation/controller/login_states.dart';
import 'package:mr_candy/features/sign_up/presentation/views/sign_up_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  var formKey = GlobalKey<FormState>();
  var passwordNode = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.ltr : ui.TextDirection.rtl,
      child: Container(
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            CustomField(
                              keyboardType: TextInputType.emailAddress,
                              hintTitle: "textLabelEmail".tr(),
                              iconData: Icons.email_outlined,
                              errorMessage: "errorEmail".tr(),
                              controller: emailController,
                              onFieldSubmitted: (p0) {
                                FocusScope.of(context).requestFocus(
                                  passwordNode,
                                );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            CustomField(
                              keyboardType: TextInputType.visiblePassword,
                              hintTitle: "textLabelPassword".tr(),
                              iconData: Icons.lock_outline_rounded,
                              errorMessage: "errorPassword".tr(),
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
                            BlocConsumer<LoginCubit, LoginStates>(
                              listener: (context, state) async {
                                if (state is LoginFailureStates) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage),
                                      backgroundColor: AppColors.red,
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                    ),
                                  );
                                } else if (state is LoginSuccessStates) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("loginSuccess".tr()),
                                      backgroundColor: AppColors.green,
                                      behavior: SnackBarBehavior.floating,
                                      showCloseIcon: true,
                                    ),
                                  );
                                  await Future.delayed(
                                    const Duration(seconds: 2),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const HomeBottomScreen();
                                      },
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is LoginLoadingStates
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : CustomButton(
                                        titleButton: "login".tr(),
                                        onTap: () {
                                          if (formKey.currentState!.validate()) {
                                            FocusScope.of(context).requestFocus(
                                              FocusNode(),
                                            );
                                            BlocProvider.of<LoginCubit>(context)
                                                .login(
                                              email: emailController.text.trim(),
                                              password:
                                                  passwordController.text.trim(),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SignUpScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "createAnAccount".tr(),
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
                                  "dontHaveAnAccount".tr(),
                                  style: GoogleFonts.almarai(
                                    color: AppColors.dontHaveAnAccount,
                                    fontSize: MediaQuery.of(context).size.height *
                                        0.018,
                                    fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
