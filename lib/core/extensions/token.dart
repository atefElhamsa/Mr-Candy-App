import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/utils/app_texts.dart';

class AuthHelper {
  static String? getToken() {
    return Hive.box(AppTexts.nameOfBox).get("token");
  }

  static void saveToken(String token) {
    Hive.box(AppTexts.nameOfBox).put("token", token);
  }

  static void removeToken() {
    Hive.box(AppTexts.nameOfBox).delete("token");
  }
}
