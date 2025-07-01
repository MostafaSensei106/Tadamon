import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/widgets/app_toast/app_toast.dart';
import '../../../pages/search_page/data/model/search_product_model.dart';
import '../models/product_model.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _tadamonProductsCollection = 'TadamonProducts';
  static const String _productReportCollection = 'TadamonUserReport';

  Future<void> addProduct(final ProductModel product) async {
    try {
      await _firestore
          .collection(_tadamonProductsCollection)
          .add(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<List<ProductModel>> downloadAllProductsFromFirebase() async {
    try {
      final snapshot = await _firestore
          .collection(_tadamonProductsCollection)
          .get();
      return snapshot.docs
          .map((final doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _firestore
          .collection(_tadamonProductsCollection)
          .get();
      return snapshot.docs
          .map((final doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  Future<void> updateProduct(final String documnetId, final ProductModel product) async {
    try {
      await _firestore
          .collection(_tadamonProductsCollection)
          .doc(documnetId)
          .update(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<void> deleteProduct(final String documnetId) async {
    try {
      await _firestore
          .collection(_tadamonProductsCollection)
          .doc(documnetId)
          .delete();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<dynamic> getProductBySerialNumber(final String serialNumber) async {
    try {
      final snapshot = await _firestore
          .collection(_tadamonProductsCollection)
          .doc(serialNumber)
          .get();
      final data = snapshot.data();
      if (data != null) {
        return ProductModel.fromMap(data);
      } else {
        return ProductModel(
          name: 'غير موجود',
          serialNumber: serialNumber,
          manufacture: 'غير معروف المصنع',
          category: 'غير معروف',
          trusted: false,
          onError: 'Product not found',
        );
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<List<ProductSearchModel>> searchInFireStore(
    String searchTerm,
    final String filter,
  ) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    searchTerm = searchTerm.toLowerCase();
    final CollectionReference productsCollection = _firestore.collection(
      _tadamonProductsCollection,
    );

    final query = productsCollection
        .orderBy(filter)
        .startAt([searchTerm])
        .endAt(['$searchTerm\uF8FF']);

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((final doc) => ProductSearchModel.fromDocument(doc))
        .toList();
  }

  Future<void> sendReportToBackEnd(final Map<String, dynamic> productReport) async {
    final String productName = productReport['productName'];
    final DocumentReference documentReference = _firestore
        .collection(_productReportCollection)
        .doc(productName);
    await documentReference.set(productReport);
  }

  Stream<int> getProductsCount() => _firestore
        .collection(_tadamonProductsCollection)
        .snapshots()
        .map((final snapshots) => snapshots.docs.length);
}
