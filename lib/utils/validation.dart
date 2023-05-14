class Validation {
  static String validateValueEmail(String value, String title,
      [bool isEmail = false]) {
    if (value.isEmpty)
      return title + ' is required';
    else if (isEmail && value.isNotEmpty) {
      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  static String validateValue(String value, String title,
      [bool isEmail = false]) {
    if (value.isEmpty || value == '' || value == null)
      return '*';
    else if (isEmail && value.isNotEmpty) {
      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  static String validatePassword(String value, String title,
      [bool confirmPass = false, String confirmPassVal = '']) {
    if (value.isEmpty || value == '' || value == null)
      return '*';
    else if (value.isNotEmpty && confirmPass && value != confirmPassVal) {
      return "Confirm Password does not match";
    } else if (value.length < 6) {
      return "Password length should be 6 character long";
    } else if (value.isNotEmpty) {
      if (!RegExp(r'^[a-zA-Z0-9&%=]+$').hasMatch(value)) {
        return 'Please enter an alphanumeric password';
      }
    }
    return null;
  }

  bool isEmpty(String value) {
    if (value.isEmpty) return true;

    return false;
  }

  static String validateLoginEmailValue(String value, String title,
      [bool isEmail = false]) {
    if (value.isEmpty)
      return title + ' is required';
    else if (isEmail && value.isNotEmpty) {
      List<String> emailArray = value.split('@');
      if (emailArray.length > 1) {
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      } else {
        return null;
      }
    }
    return null;
  }
}
//flutter_form_builder:
