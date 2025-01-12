import 'package:flutter/material.dart';
import 'package:mr_candy/core/utils/app_texts.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.errorMessage, this.onPressed});
  final String errorMessage;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(errorMessage),
        MaterialButton(
          onPressed: onPressed,
          child: const Text(AppTexts.retry),
        ),
      ],
    );
  }
}
