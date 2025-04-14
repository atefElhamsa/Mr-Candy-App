import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.backgroundImage});
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.loginAppbar3,
          width: 4,
        ),
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundImage: backgroundImage,
      ),
    );
  }
}
