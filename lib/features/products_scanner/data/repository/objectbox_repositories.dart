import 'package:tadamon/core/services/object_box_services/object_box_service.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';

class ObjectboxRepository {
  Future<void> syncAllProductsToLocalDB() async {
    try {
      final List<ProductModel> products = await FireStoreRepository()
          .downloadAllProductsFromFirebase();
      ObjectBoxService.instance.tadamonProductsBox.putMany(products);
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء تحميل المنتجات من قاعدة البيانات');
    }
  }

  Future<bool> tadamonProductsBoxHasData() async {
    var box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    return box.isNotEmpty;
  }

  Future<bool> tadamonLogsBoxHasData() async {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box.isNotEmpty;
  }

  Future<dynamic> getTadamonProductBySerialNumber(String serialNumber) async {
    var box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    try {
      var data = box.firstWhere(
        (element) => element.serialNumber == serialNumber,
        orElse: () => ProductModel(
          name: 'غير موجود',
          serialNumber: serialNumber,
          manufacture: ' غير معروف المصنع',
          category: 'غير معروف',
          trusted: false,
          onError: 'Product not found',
        ),
      );
      return ProductModel.fromMap(data.toMap());
    } catch (e) {
      AppToast.showErrorToast('Error in getTadamonProductBySerialNumber :$e');
    }
  }

  Future<void> deleteAllTadamonProductsFromLocalDB() async {
    try {
      ObjectBoxService.instance.tadamonProductsBox.removeAll();
    } catch (e) {
      AppToast.showErrorToast(
        'An error occurred while deleting products from the local database',
      );
    }
  }

  Future<void> clearTadamonLogsFromLocalDB() async {
    try {
      if (ObjectBoxService.instance.tadamonLogsBox.isEmpty()) {
        AppToast.showErrorToast('NO DATA TO BE CLEARED');
      } else {
        ObjectBoxService.instance.tadamonLogsBox.removeAll();
        AppToast.showSuccessToast('DATA HAS BEEN DELETED');
      }
    } catch (e) {
      AppToast.showErrorToast(
        'An error occurred while deleting Logs from the local database',
      );
    }
  }

  Future<void> saveProductToTadamonLogs(ScannedLogsProductModel product) async {
    try {
      ObjectBoxService.instance.tadamonLogsBox.put(product);
      AppToast.showSuccessToast('Product saved successfully');
    } catch (e) {
      AppToast.showErrorToast('An error occurred while saving the product: $e');
    }
  }

  Future<List<ScannedLogsProductModel>> getAllTadamonLogs() async {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box;
  }

  Future<List<ScannedLogsProductModel>> searchProductsBySerialNumber(
    String query,
  ) async {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box
        .where((product) => product.serialNumber.contains(query))
        .toList();
  }

  List<ScannedLogsProductModel> saveLogsTOPDF() {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box
        .map((product) => ScannedLogsProductModel.fromMap(product.toMap()))
        .toList();
  }

  Stream<int> getTadamonLogsProductsCount() async* {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    yield box.length;
  }
}
