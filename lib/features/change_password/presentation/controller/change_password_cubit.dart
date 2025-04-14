import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/core/errors/failure.dart';
import 'package:mr_candy/features/change_password/presentation/controller/change_password_state.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  final SettingRepo settingRepo;
  ChangePasswordCubit({required this.settingRepo})
      : super(ChangePasswordInitialState());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    final Either<Failure, String> result = await settingRepo.changepassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (l) => emit(
        ChangePasswordFailureState(errorMessage: l.message),
      ),
      (r) => emit(
        ChangePasswordSuccessState(message: r),
      ),
    );
  }
}
