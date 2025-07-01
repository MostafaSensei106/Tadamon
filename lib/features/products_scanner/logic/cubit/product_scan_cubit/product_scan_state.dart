part of 'product_scan_cubit.dart';

@immutable
sealed class ProductScanState {}

final class ProductScanInitial extends ProductScanState {}

class ProductScanLoading extends ProductScanState {}

class ProductScanSuccess extends ProductScanState {}

class ProductScanError extends ProductScanState {
  ProductScanError(this.message);
  final String message;
}

class ProductScanNotFound extends ProductScanState {}

class ProductScanFromLocal extends ProductScanState {}

class ProductScanFromBackEnd extends ProductScanState {
  ProductScanFromBackEnd(this.product);
  final ProductModel product;
}
