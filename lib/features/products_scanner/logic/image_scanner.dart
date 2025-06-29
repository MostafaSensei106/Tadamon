import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tadamon/features/products_scanner/logic/barcode_validator.dart';

class ImageScanner {
  /// Selects an image from the gallery and returns its path.
  ///
  /// Shows an error toast if the image selection fails.
  ///
  Future<XFile?> _pickGalleryImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 45,
      );
      return image;
    } catch (e) {
      AppToast.showErrorToast('حدث خطاء اثناء اختيار الصورة: ${e.toString()}');
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

  Future<String> _getBarcodeFromImage(XFile? image) async {
    try {
      if (image == null) {
        AppToast.showErrorToast('لم يتم اختيار الصورة');
        return '-1';
      }

      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final BarcodeScanner barcodeScanner = BarcodeScanner();
      final List<Barcode> barcodes = await barcodeScanner.processImage(
        inputImage,
      );
      if (barcodes.isEmpty || barcodes.first.rawValue == null) {
        AppToast.showErrorToast('لا يوجد باركود في الصورة');
        return '-1';
      }

      final String barcodeRawValue = barcodes.first.rawValue!;
      if (!BarcodeValidator.isNumber(barcodeRawValue)) {
        AppToast.showErrorToast(
          'الباركود :$barcodeRawValue غير صالح، يجب أن يكون رقمًا فقط',
        );
        return '-1';
      }

      return barcodeRawValue;
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء معالجة الصورة: ${e.toString()}');
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
  Future<String> scanBarcodeFromImage(BuildContext context) async {
    try {
      final XFile? image = await _pickGalleryImage();

      final String barcode = await _getBarcodeFromImage(image);
      return barcode;
    } catch (e) {
      AppToast.showErrorToast('حدث خطاء اثناء تحليل الصورة: ${e.toString()}');
      return '-404';
    }
  }
}
