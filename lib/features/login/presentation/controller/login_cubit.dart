import 'package:flutter_bloc/flutter_bloc.dart';
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
      (r) {
        emit(LoginSuccessStates(userModel: r));
      },
    );
  }
}
