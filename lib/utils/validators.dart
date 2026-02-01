import 'package:nb_utils/nb_utils.dart';

class Validators {
  Validators._();

  static String? emptyValidator(String? value, String message) {
    if (value?.trim().isEmpty == true) return message;

    return null;
  }

  static String? lengthValidator(String? value, int length, String message) {
    if (value == null) return null;

    if (value.trim().length < length) return message;

    return null;
  }

  static String? emailValidator(String? value) {
    if (value?.trim().isEmpty == true) return "Enter your email address";

    if (value?.trim().validateEmail() != true) return "Enter a valid email";

    return null;
  }
}
