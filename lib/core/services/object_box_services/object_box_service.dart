import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart'
    show ScannedLogsProductModel;
import 'package:tadamon/features/products_scanner/data/models/product_model.dart'
    show ProductModel;
import 'package:tadamon/objectbox.g.dart' show Store, Box, openStore;

class ObjectBoxService {
  static final ObjectBoxService _instance = ObjectBoxService._internal();
  late final Store store;
  late final Box<ProductModel> tadamonProductsBox;
  late final Box<ScannedLogsProductModel> tadamonLogsBox;

  ObjectBoxService._internal();

  /// Initialize the ObjectBox store and boxes.
  ///
  /// This function must be called before using any of the other methods of
  /// [ObjectBoxService].
  ///
  /// The method is asynchronous and returns a [Future] that completes when the
  /// store and boxes have been initialized.
  ///
  /// The function can be called multiple times, but the store and boxes will
  /// only be initialized once. After the first call, the function will return
  /// a completed [Future] immediately.
  static Future<void> init() async {
    _instance.store = await openStore();
    _instance.tadamonProductsBox = Box<ProductModel>(_instance.store);
    _instance.tadamonLogsBox = Box<ScannedLogsProductModel>(_instance.store);
  }

  static ObjectBoxService get instance => _instance;
}
