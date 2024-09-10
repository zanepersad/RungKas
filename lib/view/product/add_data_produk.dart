import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:test_1/service/product_service.dart';
import 'package:test_1/widget/barcode.dart';

class AddDataProduct extends StatefulWidget {
  const AddDataProduct({super.key});

  @override
  State<AddDataProduct> createState() => _AddDataProductState();
}

class _AddDataProductState extends State<AddDataProduct> {
  final produkIDcontroller = TextEditingController();
  final namaProdukcontroller = TextEditingController();
  final jumlahProdukcontroller = TextEditingController();
  final hargaProdukController = TextEditingController();
  String _scanressult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tambahkan data"),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/data_product');
              },
              child: Icon(
                Icons.data_object,
                size: 24.sp,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              Image.asset(
                'asset/add.png',
                height: 30.h,
                width: 30.w,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.w, right: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 1.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: Size(90.w, 6.4.h)),
                      onPressed: () async {
                        _scanressult = await scanBarcode();
                        setState(() {});
                        produkIDcontroller.text = _scanressult;
                      },
                      child: const Center(child: Text("Scan")),
                    ),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: produkIDcontroller,
                      cursorColor: const Color.fromARGB(255, 152, 114, 114),
                      decoration: InputDecoration(
                        hintText: "Produk ID",
                        labelText: "Hasil Pindai",
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
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
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: namaProdukcontroller,
                      cursorColor: const Color.fromARGB(255, 152, 114, 114),
                      decoration: InputDecoration(
                        hintText: "Nama Produk",
                        labelText: "Nama Produk",
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
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
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: jumlahProdukcontroller,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Jumlah Produk",
                        labelText: "Jumlah Produk",
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
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
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: hargaProdukController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Harga Produk",
                        labelText: "Harga Produk",
                        labelStyle: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
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
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(90.w, 6.4.h),
                      ),
                      onPressed: () async {
                        await ProductService.createProduct(
                          namaProduk: namaProdukcontroller.text,
                          jumlahProduk: int.parse(jumlahProdukcontroller.text),
                          hargaProduk: double.parse(hargaProdukController.text),
                          produkID: _scanressult,
                        );
                        produkIDcontroller.clear();
                        namaProdukcontroller.clear();
                        jumlahProdukcontroller.clear();
                        hargaProdukController.clear();
                      },
                      child: const Text("Tambahkan"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
