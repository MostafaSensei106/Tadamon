import 'package:objectbox/objectbox.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

@Entity()
class ScannedLogsProductModel {
  @Id()
  int id = 0;

  String name;
  String serialNumber;
  String manufacture;
  String category;
  bool trusted;
  String onError;
  DateTime scannedAt;

  ScannedLogsProductModel({
    this.id = 0,
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    required this.trusted,
    this.onError = '',
    DateTime? scannedAt,
  }) : scannedAt = scannedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'serialNumber': serialNumber,
      'productManufacturer': manufacture,
      'productCategory': category,
      'isTrusted': trusted,
      'onError': onError,
      'scannedAt': scannedAt.toIso8601String(),
    };
  }

  factory ScannedLogsProductModel.fromMap(Map<String, dynamic> map) {
    return ScannedLogsProductModel(
      name: map['productName'],
      serialNumber: map['serialNumber'],
      manufacture: map['productManufacturer'],
      category: map['productCategory'],
      trusted: map['isTrusted'],
      scannedAt: DateTime.parse(
        map['scannedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  factory ScannedLogsProductModel.fromProduct(ProductModel product) {
    return ScannedLogsProductModel(
      name: product.name,
      serialNumber: product.serialNumber,
      manufacture: product.manufacture,
      category: product.category,
      trusted: product.trusted,
      scannedAt: DateTime.now(),
    );
  }
}
