class BarcodeValidator {
  static bool isNumber(String barcode) {
    final RegExp regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(barcode);
  }
}
