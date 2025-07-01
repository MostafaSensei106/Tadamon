import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSearchModel {

  ProductSearchModel({
    required this.id,
    required this.serialNumber,
    required this.name,
    required this.manufacturer,
    required this.trusted,
    required this.category,
  });

  factory ProductSearchModel.fromDocument(final QueryDocumentSnapshot doc) => ProductSearchModel(
      id: doc.id,
      serialNumber: doc['SerialNumber'],
      name: doc['Name'],
      manufacturer: doc['Manufacture'],
      trusted: doc['Trusted'],
      category: doc['Category'],
    );
  final String id;
  final String serialNumber;
  final String name;
  final String manufacturer;
  final bool trusted;
  final String category;
}
