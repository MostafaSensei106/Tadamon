class BarcodeValidator {
  static bool isNumber(final String barcode) {
    final regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(barcode);
  }
}
