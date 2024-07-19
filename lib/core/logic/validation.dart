class ValidationText {
  String? codeValidation(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Empty field please enter value';
    }
    return null;
  }
}
