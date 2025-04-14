import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_candy/features/profile/presentation/controller/profile_cubit.dart';
import 'package:mr_candy/features/profile/presentation/view/widgets/edit_profile_page_body.dart';
import 'package:mr_candy/features/setting/data/repo/setting_repo_implementation.dart';

import '../../data/model/profile_model.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileModel profile;
  const EditProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        settingRepo: SettingRepoImplementation(),
      ),
      child: EditProfilePageBody(profile: profile),
    );
  }
}
