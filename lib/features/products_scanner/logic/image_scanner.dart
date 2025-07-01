import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widgets/app_toast/app_toast.dart';
import 'barcode_validator.dart';

class ImageScanner {
  /// Selects an image from the gallery and returns its path.
  ///
  /// Shows an error toast if the image selection fails.
  ///
  Future<XFile?> _pickGalleryImage() async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 45,
      );
      return image;
    } catch (e) {
      showErrorToast('حدث خطاء اثناء اختيار الصورة: ${e.toString()}');
      return null;
    }
  }

  /// Processes the given image to extract a barcode.
  ///
  /// This method uses a barcode scanner to process the provided image and
  /// extract any barcodes present. If barcodes are found, the raw value of
  /// the first barcode is returned. If no barcodes are detected or an error
  /// occurs during processing, `null` is returned.
  ///
  /// Shows an error toast if an exception occurs during barcode processing.
  ///
  /// [image] The image file to be processed for barcode extraction.
  ///
  /// Returns the raw value of the first detected barcode, or `null` if no
  /// barcodes are found or an error occurs.

  Future<String> _getBarcodeFromImage(final XFile? image) async {
    try {
      if (image == null) {
        showErrorToast('لم يتم اختيار الصورة');
        return '-1';
      }

      final inputImage = InputImage.fromFilePath(image.path);
      final barcodeScanner = BarcodeScanner();
      final barcodes = await barcodeScanner.processImage(inputImage);
      if (barcodes.isEmpty || barcodes.first.rawValue == null) {
        showErrorToast('لا يوجد باركود في الصورة');
        return '-1';
      }

      final barcodeRawValue = barcodes.first.rawValue!;
      if (!isBarcodeNumber(barcodeRawValue)) {
        showErrorToast(
          'الباركود :$barcodeRawValue غير صالح، يجب أن يكون رقمًا فقط',
        );
        return '-1';
      }

      return barcodeRawValue;
    } catch (e) {
      showErrorToast('حدث خطأ أثناء معالجة الصورة: ${e.toString()}');
      return '-404';
    }
  }

  /// Scans the given image for barcodes.
  ///
  /// This method displays an image picker to the user and asks them to select
  /// an image. The selected image is then processed to detect any barcodes
  /// present. If a barcode is detected, its raw value is returned as a string.
  /// If no barcodes are detected or an error occurs during processing, `null`
  /// is returned.
  ///
  /// Shows an error toast if an exception occurs during barcode processing or
  /// if the detected barcode is not a valid number.
  ///
  /// [context] The build context of the widget that called this method.
  ///
  /// Returns the raw value of the first detected barcode, or '-404' if no
  /// barcodes are found or an error occurs.
  Future<String> scanBarcodeFromImage(final BuildContext context) async {
    try {
      final image = await _pickGalleryImage();

      final barcode = await _getBarcodeFromImage(image);
      return barcode;
    } catch (e) {
      showErrorToast('حدث خطاء اثناء تحليل الصورة: ${e.toString()}');
      return '-404';
    }
  }
}
