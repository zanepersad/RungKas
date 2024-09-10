import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:test_1/widget/barcode.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  User? user = FirebaseAuth.instance.currentUser;
  final userData = FirebaseFirestore.instance.collection('userdata');
  late final userDocument = userData.doc(user!.uid);
  late final userCollection = userDocument.collection('product');
  String _scanResult = '';
  TextEditingController inputNama = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List _scanResultData = [];
  List<int> _itemCount = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
          ),
        ),
        title: const Text(
          "Scan Produk",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 4.h),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shadowColor: Colors.grey,
                  minimumSize: Size(90.w, 6.5.h),
                ),
                onPressed: () async {
                  _scanResult = await scanBarcode();
                  final queryScanpshot = await userCollection
                      .where('produkID', isEqualTo: _scanResult)
                      .get();
                  if (queryScanpshot.docs.isNotEmpty) {
                    setState(() {
                      _scanResultData.addAll(
                        queryScanpshot.docs.map((doc) => doc.data()).toList(),
                      );
                      _itemCount = List.filled(_scanResultData.length, 1);
                    });
                  } else {
                    setState(() {
                      _scanResultData = [];
                      print('no document found');
                    });
                  }
                },
                child: const Center(
                  child: Text("Scan Produk"),
                ),
              ),
              SizedBox(height: 1.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.greenAccent,
                  side: const BorderSide(
                    color: Colors.redAccent,
                  ),
                  minimumSize: Size(90.w, 6.5.h),
                ),
                onPressed: () {
                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat(' dd MMMM yyyy HH:mm:ss').format(now);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Nama Pelanggann"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Batal",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              onPressed: () {},
                              child: const Text(
                                "Simpan",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                          content: SizedBox(
                            height: 10.h,
                            width: 70.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: inputNama,
                                  cursorColor:
                                      const Color.fromARGB(255, 152, 114, 114),
                                  decoration: InputDecoration(
                                    hintText: "Nama",
                                    labelText: "Nama",
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
                                SizedBox(height: 1.h),
                                Expanded(child: Text(formattedDate)),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Center(
                  child: Text(
                    "Selesai",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: _scanResultData.isEmpty
                    ? const Center(
                        child: Text("data tidak ada"),
                      )
                    : ListView.builder(
                        itemCount: _scanResultData.length,
                        itemBuilder: (context, index) {
                          if (_itemCount.length <= index) {
                            _audioPlayer.play(AssetSource('asset/beep-06.mp3'));

                            _itemCount.add(1);
                          }
                          return Dismissible(
                            key: Key(
                                index.toString()), // unique key for each item
                            direction: DismissDirection
                                .endToStart, // swipe from right to left
                            onDismissed: (direction) {
                              setState(() {
                                _scanResultData.removeAt(index);
                                _itemCount.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Item dihapus")));
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Produk: ${_scanResultData[index]['namaProduk']}\n"
                                        "Harga Produk: ${_scanResultData[index]['hargaProduk']}\n"
                                        "Produk ID: ${_scanResultData[index]['produkID']}\n",
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_itemCount[index] > 0) {
                                              _itemCount[index]--;
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Text("${_itemCount[index]}"),
                                      SizedBox(width: 3.w),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _itemCount[index]++;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 3.h),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: BottomAppBar(
                  color: Colors.redAccent,
                  height: 8.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Total Jumlah : ${_itemCount.fold(0, (sum, element) => sum + element)}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Total Harga : ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(_scanResultData.isNotEmpty ? _scanResultData.asMap().entries.map((e) => e.value['hargaProduk'] * _itemCount[e.key]).reduce((a, b) => a + b) : 0)}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
