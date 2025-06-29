import 'package:objectbox/objectbox.dart';

@Entity()
class ProductModel {
  @Id()
  int id = 0;

  String name;
  String serialNumber;
  String manufacture;
  String category;
  //String productBoycottResonLink;
  bool trusted;
  String onError;

  ProductModel({
    this.id = 0,
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    //required this.productBoycottResonLink,
    required this.trusted,
    this.onError = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'SerialNumber': serialNumber,
      'Manufacture': manufacture,
      'Category': category,
      'Trusted': trusted,
      'onError': onError,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['Name'] ?? '',
      serialNumber: map['SerialNumber'] ?? '',
      manufacture: map['Manufacture'] ?? '',
      category: map['Category'] ?? '',
      trusted: map['Trusted'] ?? false,
      onError: map['onError'] ?? '',
    );
  }
}
