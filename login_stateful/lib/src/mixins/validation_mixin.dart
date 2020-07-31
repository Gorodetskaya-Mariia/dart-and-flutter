class ValidationMixin {
  String validatePassword(String value) {
    if (value.length <= 5) {
      return 'Password must be at least 6 characters';
    }
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
  }
}
