import 'package:equatable/equatable.dart';
import 'package:mr_candy/features/profile/data/model/profile_model.dart';

abstract class ProfileStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final ProfileModel profile;
  ProfileSuccessState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileFailureState extends ProfileStates {
  final String errorMessage;
  ProfileFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class EditProfileLoadingState extends ProfileStates {}

class EditProfileUpdatedState extends ProfileStates {}

class EditProfileSuccessState extends ProfileStates {
  final String message;

  EditProfileSuccessState({required this.message});
}

class EditProfileFailureState extends ProfileStates {
  final String errorMessage;

  EditProfileFailureState({required this.errorMessage});
}

class EditProfileImageUploadedState extends ProfileStates {
  final String imageUrl;

  EditProfileImageUploadedState({required this.imageUrl});
}
