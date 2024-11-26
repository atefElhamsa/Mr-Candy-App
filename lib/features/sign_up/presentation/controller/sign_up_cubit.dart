import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/sign_up/data/models/sign_up_model.dart';
import 'package:mr_candy/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:mr_candy/features/sign_up/presentation/controller/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit({required this.signUpRepo}) : super(SignUpInitialStates());
  final SignUpRepo signUpRepo;

  Future<void> signUp({
    required UserSignUpModel userSignUpModel,
  }) async {
    emit(SignUpLoadingStates());
    var result = await signUpRepo.signUp(userSignUpModel: userSignUpModel);
    result.fold(
      (l) {
        emit(SignUpFailureStates(errorMessage: l.message));
      },
      (r) async {
        var box = Hive.box(AppTexts.nameOfBox);
        await box.put(AppTexts.token, r.token);
        emit(SignUpSuccessStates(userModel: r));
      },
    );
  }

  XFile? image;
  String? imageToBase64;
  final ImagePicker imagePicker = ImagePicker();
  Future<void> pickImageProfile() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image!.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      imageToBase64 = base64Encode(imageBytes);
    }
    emit(PickedImageStates());
  }
}
