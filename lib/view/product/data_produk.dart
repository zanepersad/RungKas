import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_1/service/product_service.dart';
import 'package:test_1/widget/showmodalbottom.dart';

class dataProduct extends StatefulWidget {
  const dataProduct({super.key});

  @override
  State<dataProduct> createState() => _dataProductState();
}

class _dataProductState extends State<dataProduct> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/add_product');
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 24.sp,
                ),
              )
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: _productService.shoProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 1.5.h, left: 2.w, right: 2.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.yellow,
                                Colors.orange,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(document['namaProduk']),
                            subtitle: Text(
                              'ID: ${document['produkID']}, Jumlah: ${document['jumlahProduk']}, Harga: ${document['hargaProduk']}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ModalBottom(
                                  document: document,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _productService
                                        .deleteProduct(document['produkID']);
                                  },
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: 30.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasData) {
                  return Center(
                    child: Text("error ${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
