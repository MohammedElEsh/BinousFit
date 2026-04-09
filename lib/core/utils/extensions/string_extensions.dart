/// String helpers for forms and display.
extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isEmail {
    final r = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return r.hasMatch(this);
  }

  bool get isPhone {
    final digits = replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10;
  }
}

extension NullableStringExtensions on String? {
  bool get isRequiredMissing => this == null || this!.trim().isEmpty;
}
