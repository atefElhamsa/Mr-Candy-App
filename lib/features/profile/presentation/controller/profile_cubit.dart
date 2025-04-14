import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_state.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/profile_model.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final SettingRepo settingRepo;

  ProfileCubit({required this.settingRepo}) : super(ProfileInitialState());

  XFile? myPhoto;
  String? uploadedImageUrl;

  Future<XFile?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void choosePhoto() {
    pickImage().then((value) {
      if (value != null) {
        myPhoto = value;
        uploadedImageUrl = myPhoto!.path;
        emit(
          EditProfileImageUploadedState(imageUrl: uploadedImageUrl!),
        );
      }
    });
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoadingState());

    final Either<Failure, ProfileModel> result = await settingRepo.getprofile();

    result.fold(
      (failure) => emit(
        ProfileFailureState(errorMessage: failure.message),
      ),
      (profile) => emit(
        ProfileSuccessState(profile: profile),
      ),
    );
  }

  Future<void> editProfile({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
  }) async {
    if (myPhoto == null) {
      emit(
        EditProfileFailureState(errorMessage: "Please select an image first."),
      );
      return;
    }
    File imageFile = File(myPhoto!.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);
    emit(EditProfileLoadingState());
    final Either<Failure, String> result = await settingRepo.editprofile(
      name: name,
      email: email,
      password: password,
      phone: phone,
      image: base64String,
    );
    result.fold(
      (l) {
        emit(
          EditProfileFailureState(errorMessage: l.message),
        );
      },
      (r) {
        uploadedImageUrl = r;
        emit(
          EditProfileSuccessState(message: "Profile Updated Successfully"),
        );
      },
    );
  }
}
