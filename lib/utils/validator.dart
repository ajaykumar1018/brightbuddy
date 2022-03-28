class FieldValidator {
  /////////////////////////Add Barber//////////////////////
  ////////////////////////////////////////////////////////

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    // if (value.length < 6)
    //   return "Password should consists of minimum 6 character";
    // if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
    //   return 'Password should include at least 1 number';
    // }
    // if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
    //   return 'Password should include 1 special character';
    // }
    return null;
  }

  static String validateOldPassword(String value) {
    if (value.isEmpty) return "Old password is required";
    if (value.length < 6)
      return "Old password should consists of minimum 6 character";
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return 'Old password should include at least 1 number';
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return 'Old password should include 1 special character';
    }
    return null;
  }

  static String validatePasswordMatch(String value, String pass2) {
    if (value.isEmpty) return "Confirm password is required";
    if (value != pass2) {
      return 'Password didn\'t match';
    }
    return null;
  }

  static String validateOTP(String value) {
    if (value.isEmpty) return "OTP is required";
    if (!RegExp(r'^(?=.*?[0-9])(?!.*?[!@#\$&*~+/.,():N]).{6,}$')
        .hasMatch(value.trim())) {
      return "Please enter a valid OTP";
    }
    return null;
  }

  static String validateFullName(String value) {
    if (value.isEmpty) return "Full name is required";
    if (value.length <= 2) {
      return "Full name is too short";
    }
    if (!RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$").hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String validatePhoneNumber(String value) {
    if (value.isEmpty) return "Phone number is required";
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,20}$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  static String validateAge(String value) {
    if (value.isEmpty) return "Age is required";
    return null;
  }

  static String validateMessage(String value) {
    if (value.isEmpty) return "Message is required";
    if (value.length <= 10) {
      return "Message is too short";
    }
    if (value.length >= 350) {
      return "Message must be less than 350 characters.";
    }
    return null;
  }

  static String validateEventName(String value) {
    if (value.isEmpty) return "Event name is required";
    if (value.length <= 2) {
      return "Event name is too short";
    }
    return null;
  }

  static String validateStartingDate(String value) {
    if (value.isEmpty) return "Starting date is required";
    return null;
  }

  static String validateStartingTime(String value) {
    if (value.isEmpty) return "Starting time is required";
    return null;
  }

  static String validateAboutEvent(String value) {
    if (value.isEmpty) return "About your event is required";
    if (value.length <= 10) {
      return "About your event is too short";
    }
    return null;
  }

  static String validateStreetAddress(String value) {
    if (value.isEmpty) return "Street address is required";
    if (value.length <= 3) {
      return "Street address is too short";
    }
    return null;
  }

  static String validateCountry(String value) {
    if (value.isEmpty) return "Country is required";
    return null;
  }

  static String validateUnit(String value) {
    if (value.isEmpty) return "Unit is required";
    return null;
  }
}
