import 'package:objectbox/objectbox.dart';

@Entity()
class ProductModel {

  ProductModel({
    required this.name, required this.serialNumber, required this.manufacture, required this.category, //required this.productBoycottResonLink,
    required this.trusted, this.id = 0,
    this.onError = '',
  });

  factory ProductModel.fromMap(final Map<String, dynamic> map) => ProductModel(
      name: map['Name'] ?? '',
      serialNumber: map['SerialNumber'] ?? '',
      manufacture: map['Manufacture'] ?? '',
      category: map['Category'] ?? '',
      trusted: map['Trusted'] ?? false,
      onError: map['onError'] ?? '',
    );
  @Id()
  int id = 0;

  String name;
  String serialNumber;
  String manufacture;
  String category;
  //String productBoycottResonLink;
  bool trusted;
  String onError;

  Map<String, dynamic> toMap() => {
      'Name': name,
      'SerialNumber': serialNumber,
      'Manufacture': manufacture,
      'Category': category,
      'Trusted': trusted,
      'onError': onError,
    };
}
