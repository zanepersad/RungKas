import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_1/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  static Future<void> createProduct({
    required String namaProduk,
    required int jumlahProduk,
    required double hargaProduk,
    required String produkID,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    final userData = FirebaseFirestore.instance.collection('userdata');
    final userDocument = userData.doc(user!.uid);
    final producCollection = userDocument.collection('product');

    await producCollection.doc(produkID).set(
          Product(
            produkID: produkID,
            namaProduk: namaProduk,
            jumlahProduk: jumlahProduk,
            hargaProduk: hargaProduk,
          ).toMap(),
        );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> shoProduct() {
    return _firestore
        .collection('userdata')
        .doc(user!.uid)
        .collection('product')
        .snapshots();
  }

  Future<void> deleteProduct(String productID) async {
    User? user = FirebaseAuth.instance.currentUser;
    final userData = FirebaseFirestore.instance.collection('userdata');
    final userDocument = userData.doc(user!.uid);
    final productCollection = userDocument.collection('product');

    await productCollection.doc(productID).delete();
  }

  Future<void> updateProduct({
    required String produkID,
    required String namaProduk,
    required int? jumlahProduk,
    required double hargaProduk,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    final userdata = FirebaseFirestore.instance.collection('userdata');
    final userDocument = userdata.doc(user!.uid);
    final productCollection = userDocument.collection('product');
    try {
      await productCollection.doc(produkID).update(
            Product(
              produkID: produkID,
              namaProduk: namaProduk,
              jumlahProduk: jumlahProduk,
              hargaProduk: hargaProduk,
            ).toMap(),
          );
    } catch (e) {
      print('gagal update produk: $e');
    }
  }
}
