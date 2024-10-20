import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/login/data/repos/login_repo_implementation.dart';
import 'package:mr_candy/features/login/presentation/controller/login_cubit.dart';
import 'package:mr_candy/features/login/presentation/views/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(
          loginRepo: LoginRepoImplementation(),
        ),
        child: const LoginBody(),
      ),
    );
  }
}
