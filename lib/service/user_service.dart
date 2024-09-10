import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_1/model/user_model.dart';

class DatabaseService {
  static CollectionReference userData =
      FirebaseFirestore.instance.collection('userdata');

  static Future<void> createUpdateUser(String id,
      {required String phoneNumber}) async {
    final userDocument = userData.doc(id);
    await userDocument.set(
      User(
        id: id,
        phoneNumber: phoneNumber,
      ).toMap(),
    );

    final produkCollection = userDocument.collection('produk');
    await produkCollection.doc().set({'initialized': true});
  }
}
