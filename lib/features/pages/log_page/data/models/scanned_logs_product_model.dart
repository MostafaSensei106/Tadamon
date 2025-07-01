import 'package:objectbox/objectbox.dart';
import '../../../../products_scanner/data/models/product_model.dart';

@Entity()
class ScannedLogsProductModel {
  ScannedLogsProductModel({
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    required this.trusted,
    this.id = 0,
    this.onError = '',
    final DateTime? scannedAt,
  }) : scannedAt = scannedAt ?? DateTime.now();

  factory ScannedLogsProductModel.fromMap(final Map<String, dynamic> map) =>
      ScannedLogsProductModel(
        name: map['productName'],
        serialNumber: map['serialNumber'],
        manufacture: map['productManufacturer'],
        category: map['productCategory'],
        trusted: map['isTrusted'],
        scannedAt: DateTime.parse(
          map['scannedAt'] ?? DateTime.now().toIso8601String(),
        ),
      );

  factory ScannedLogsProductModel.fromProduct(final ProductModel product) =>
      ScannedLogsProductModel(
        name: product.name,
        serialNumber: product.serialNumber,
        manufacture: product.manufacture,
        category: product.category,
        trusted: product.trusted,
        scannedAt: DateTime.now(),
      );
  @Id()
  int id = 0;

  String name;
  String serialNumber;
  String manufacture;
  String category;
  bool trusted;
  String onError;
  DateTime scannedAt;

  Map<String, dynamic> toMap() => {
    'productName': name,
    'serialNumber': serialNumber,
    'productManufacturer': manufacture,
    'productCategory': category,
    'isTrusted': trusted,
    'onError': onError,
    'scannedAt': scannedAt.toIso8601String(),
  };
}
