class PhoneNumberValid {
  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Hãy nhập số điện thoại';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  static String? validateMobileIntroduce(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Hãy nhập Mã giới thiệu';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Mã giới thiệu không hợp lệ';
    }
    return null;
  }
}