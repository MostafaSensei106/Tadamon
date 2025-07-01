import '../../../../core/services/object_box_services/object_box_service.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../pages/log_page/data/models/scanned_logs_product_model.dart';
import '../models/product_model.dart';
import 'fire_store_repositories.dart';

class ObjectboxRepository {
  Future<void> syncAllProductsToLocalDB() async {
    try {
      final products = await FireStoreRepository()
          .downloadAllProductsFromFirebase();
      ObjectBoxService.instance.tadamonProductsBox.putMany(products);
    } catch (e) {
      showErrorToast('حدث خطأ أثناء تحميل المنتجات من قاعدة البيانات');
    }
  }

  Future<bool> tadamonProductsBoxHasData() async {
    final box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    return box.isNotEmpty;
  }

  Future<bool> tadamonLogsBoxHasData() async {
    final box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box.isNotEmpty;
  }

  Future<dynamic> getTadamonProductBySerialNumber(
    final String serialNumber,
  ) async {
    final box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    try {
      final data = box.firstWhere(
        (final element) => element.serialNumber == serialNumber,
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
      showErrorToast('Error in getTadamonProductBySerialNumber :$e');
    }
  }

  Future<void> deleteAllTadamonProductsFromLocalDB() async {
    try {
      ObjectBoxService.instance.tadamonProductsBox.removeAll();
    } catch (e) {
      showErrorToast(
        'An error occurred while deleting products from the local database',
      );
    }
  }

  Future<void> clearTadamonLogsFromLocalDB() async {
    try {
      if (ObjectBoxService.instance.tadamonLogsBox.isEmpty()) {
        showErrorToast('NO DATA TO BE CLEARED');
      } else {
        ObjectBoxService.instance.tadamonLogsBox.removeAll();
        showSuccessToast('DATA HAS BEEN DELETED');
      }
    } catch (e) {
      showErrorToast(
        'An error occurred while deleting Logs from the local database',
      );
    }
  }

  Future<void> saveProductToTadamonLogs(
    final ScannedLogsProductModel product,
  ) async {
    try {
      ObjectBoxService.instance.tadamonLogsBox.put(product);
      showSuccessToast('Product saved successfully');
    } catch (e) {
      showErrorToast('An error occurred while saving the product: $e');
    }
  }

  Future<List<ScannedLogsProductModel>> getAllTadamonLogs() async {
    final box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box;
  }

  Future<List<ScannedLogsProductModel>> searchProductsBySerialNumber(
    final String query,
  ) async {
    final box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box
        .where((final product) => product.serialNumber.contains(query))
        .toList();
  }

  List<ScannedLogsProductModel> saveLogsTOPDF() {
    final box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box
        .map(
          (final product) => ScannedLogsProductModel.fromMap(product.toMap()),
        )
        .toList();
  }

  Stream<int> getTadamonLogsProductsCount() async* {
    final box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    yield box.length;
  }
}
