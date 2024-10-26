import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/sign_up/data/repos/sign_up_repo_implementation.dart';
import 'package:mr_candy/features/sign_up/presentation/controller/sign_up_cubit.dart';
import 'package:mr_candy/features/sign_up/presentation/views/widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpCubit(
          signUpRepo: SignUpRepoImplementation(),
        ),
        child: const SignUpBody(),
      ),
    );
  }
}
