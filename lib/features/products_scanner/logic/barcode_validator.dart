bool isBarcodeNumber(final String barcode) {
  final regExp = RegExp(r'^\d+$');
  return regExp.hasMatch(barcode);
}
