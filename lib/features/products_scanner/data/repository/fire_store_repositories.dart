import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/search_page/data/model/search_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _tadamonProductsCollection = 'TadamonProducts';
  static const String _productReportCollection = 'TadamonUserReport';

  Future<void> addProduct(ProductModel product) async {
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
          .map((doc) => ProductModel.fromMap(doc.data()))
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
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  Future<void> updateProduct(String documnetId, ProductModel product) async {
    try {
      await _firestore
          .collection(_tadamonProductsCollection)
          .doc(documnetId)
          .update(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<void> deleteProduct(String documnetId) async {
    try {
      await _firestore
          .collection(_tadamonProductsCollection)
          .doc(documnetId)
          .delete();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<dynamic> getProductBySerialNumber(String serialNumber) async {
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
    String filter,
  ) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    searchTerm = searchTerm.toLowerCase();
    final CollectionReference productsCollection = _firestore.collection(
      _tadamonProductsCollection,
    );

    Query query = productsCollection
        .orderBy(filter)
        .startAt([searchTerm])
        .endAt(["$searchTerm\uF8FF"]);

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => ProductSearchModel.fromDocument(doc))
        .toList();
  }

  Future<void> sendReportToBackEnd(Map<String, dynamic> productReport) async {
    String productName = productReport['productName'];
    DocumentReference documentReference = _firestore
        .collection(_productReportCollection)
        .doc(productName);
    await documentReference.set(productReport);
  }

  Stream<int> getProductsCount() {
    return _firestore
        .collection(_tadamonProductsCollection)
        .snapshots()
        .map((snapshots) => snapshots.docs.length);
  }
}
