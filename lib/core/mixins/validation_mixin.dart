import '../utils/extensions/string_extensions.dart';

/// Form validation helpers (placeholder rules).
mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value.isRequiredMissing) {
      return 'Required';
    }
    if (!value!.isEmail) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value.isRequiredMissing) {
      return 'Required';
    }
    if (value!.length < 8) {
      return 'Too short';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value.isRequiredMissing) {
      return 'Required';
    }
    if (!value!.isPhone) {
      return 'Invalid phone';
    }
    return null;
  }

  String? validateRequired(String? value) {
    if (value.isRequiredMissing) {
      return 'Required';
    }
    return null;
  }
}
