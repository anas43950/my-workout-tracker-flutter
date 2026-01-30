import 'package:nb_utils/nb_utils.dart';

class Validators {
  Validators._();

  static String? nameValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "Enter your name";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "Enter your email address";
    }
    if (value?.trim().validateEmail() != true) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? passValidator(String? value) {
    if (value?.trim().isEmpty == true) {
      return "Enter your password";
    }
    if (value!.trim().length < 6) {
      return "Password should be at least 6 characters";
    }
    return null;
  }
}
