class Extensions {
  String? isEmail(String? text) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(text!) ? null : "Invalid Email";
  }

  String? isPassword(String? text) {
    final regex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$');
    return regex.hasMatch(text!) ? null : "Invalid Password";
  }

  String? isUser(String? text) {
    return text == null ? null : "Invalid Username";
  }
}
