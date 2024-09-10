import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_1/service/product_service.dart';

class ModalBottom extends StatefulWidget {
  final DocumentSnapshot document;
  const ModalBottom({super.key, required this.document});

  @override
  State<ModalBottom> createState() => _ModalBottomState();
}

class _ModalBottomState extends State<ModalBottom> {
  final _fromKey = GlobalKey<FormState>();
  final ProductService _productService = ProductService();

  String _namaProduk = '';
  int? _jumlahProduk;
  double _hargaProduk = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: 50.h, // Ditinggikan agar cukup ruang untuk scrolling
                width: 100.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
                  child: Form(
                    key: _fromKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Jumlah',
                            labelText: 'Ganti jumlah',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          initialValue:
                              widget.document['jumlahProduk']?.toString() ??
                                  '0',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field jumlahProduk tidak boleh Kosong';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _jumlahProduk = int.parse(value ?? '0'),
                        ),
                        SizedBox(height: 1.5.h),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Harga',
                            labelText: 'Ganti Harga',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          initialValue:
                              widget.document['hargaProduk']?.toString() ??
                                  '0.0',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field harga tidak boleh kosong';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _hargaProduk = double.parse(value ?? '0.0'),
                        ),
                        SizedBox(height: 1.5.h),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Nama',
                            labelText: 'Ganti Nama',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          initialValue: widget.document['namaProduk'] ?? '',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field nama tidak boleh kosong';
                            }
                            return null;
                          },
                          onSaved: (value) => _namaProduk = value ?? '',
                        ),
                        SizedBox(height: 2.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(90.w, 6.4.h),
                          ),
                          onPressed: () async {
                            if (_fromKey.currentState!.validate()) {
                              _fromKey.currentState!.save();
                              if (_jumlahProduk != null) {
                                await _productService.updateProduct(
                                  produkID: widget.document['produkID'],
                                  namaProduk: _namaProduk,
                                  jumlahProduk: _jumlahProduk!,
                                  hargaProduk: _hargaProduk,
                                );
                              } else {
                                print('salah satu field null');
                              }
                            }
                          },
                          child: const Text("Ubah Data"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.edit_document,
        color: Colors.white,
        size: 30.sp,
      ),
    );
  }
}
