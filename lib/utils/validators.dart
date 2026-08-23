class Validators {
  Validators._();

  // -------------------------------
  // Name Validation
  // -------------------------------
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full name is required";
    }

    if (value.trim().length < 3) {
      return "Name must contain at least 3 characters";
    }

    return null;
  }

  // -------------------------------
  // Email Validation
  // -------------------------------
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email address is required";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  // -------------------------------
  // Password Validation
  // -------------------------------
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must contain at least 6 characters";
    }

    return null;
  }

  // -------------------------------
  // Mobile Number Validation
  // -------------------------------
  static String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Mobile number is required";
    }

    final mobileRegex = RegExp(r'^[6-9]\d{9}$');

    if (!mobileRegex.hasMatch(value.trim())) {
      return "Enter a valid mobile number";
    }

    return null;
  }

  // -------------------------------
  // USN Validation
  // -------------------------------
  static String? validateUSN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "USN is required";
    }

    final usn = value.trim().toUpperCase();

    final usnRegex = RegExp(
      r'^KUB\d{2}(CSE|ISE|ECE|EEE|MECH|CIVIL|AIML|AIDS|MBA|MCA|BBA|BCA)\d{1,3}$',
    );

    if (!usnRegex.hasMatch(usn)) {
      return "Enter a valid Kishkinda University USN";
    }

    return null;
  }

  // -------------------------------
  // Faculty / Driver ID Validation
  // -------------------------------
  static String? validateID(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "ID is required";
    }

    if (value.trim().length < 3) {
      return "Enter a valid ID";
    }

    return null;
  }

  // -------------------------------
  // Route Validation
  // -------------------------------
  static String? validateRoute(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a route";
    }

    return null;
  }
}