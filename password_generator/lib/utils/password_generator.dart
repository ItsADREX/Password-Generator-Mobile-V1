import 'dart:math';

class PasswordGenerator {
  static const String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+~`|}{[]:;?><,./-=';
  final Random _rnd = Random.secure();

  String generatePassword(int length) {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  String getPasswordStrength(String password) {
    if (password.length >= 12 && 
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'Strong';
    } else if (password.length >= 8) {
      return 'Moderate';
    } else {
      return 'Weak';
    }
  }
}