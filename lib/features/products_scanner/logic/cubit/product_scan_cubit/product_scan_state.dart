part of 'product_scan_cubit.dart';

@immutable
sealed class ProductScanState {}

final class ProductScanInitial extends ProductScanState {}

class ProductScanLoading extends ProductScanState {}

class ProductScanSuccess extends ProductScanState {}

class ProductScanError extends ProductScanState {
  final String message;
  ProductScanError(this.message);
}

class ProductScanNotFound extends ProductScanState {}

class ProductScanFromLocal extends ProductScanState {}

class ProductScanFromBackEnd extends ProductScanState {
  final ProductModel product;
  ProductScanFromBackEnd(this.product);
}
