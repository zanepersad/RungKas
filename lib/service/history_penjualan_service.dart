import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_1/model/his_penjualan_model.dart';

class HistoryPenjualanService {
  static Future<void> createPenjualan({
    required String? namaPelanggan,
    required String? namaProduk,
    required int? totalJumlahProduk,
    required double? totalHarga,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    final userData = FirebaseFirestore.instance.collection('userdata');
    final userDocument = userData.doc(user!.uid);
    final penjualanCollection = userDocument.collection('penjualan');

    await penjualanCollection.doc(namaPelanggan).set(
          HistoryPenjualan(
            namaPelanggan: namaPelanggan,
            namaProduk: namaProduk,
            totalJumlahProduk: totalJumlahProduk,
            totalHarga: totalHarga,
          ).toMap(),
        );
  }
}
