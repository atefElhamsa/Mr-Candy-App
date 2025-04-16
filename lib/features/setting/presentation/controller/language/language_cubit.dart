import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('ar'));

  void changeLanguage({
    required BuildContext context,
    required String languageCode,
  }) async {
    final newLocale = Locale(languageCode);
    await context.setLocale(newLocale);
    emit(newLocale);
  }
}
