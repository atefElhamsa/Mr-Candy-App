import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/login/data/repos/login_repo.dart';
import 'package:mr_candy/features/login/presentation/controller/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({required this.loginRepo}) : super(LoginInitialStates());
  final LoginRepo loginRepo;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingStates());
    var result = await loginRepo.login(email: email, password: password);
    result.fold(
      (l) {
        emit(LoginFailureStates(errorMessage: l.message));
      },
      (r) async {
        var box = Hive.box(AppTexts.nameOfBox);
        await box.put(AppTexts.token, r.token);
        emit(LoginSuccessStates(userModel: r));
      },
    );
  }
}
