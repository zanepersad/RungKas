import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage('asset/person.jpg'),
                  radius: 50.sp,
                ),
                SizedBox(height: 1.h),
                Text(
                  "Pudin Mubarokah",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                const Text(
                  'Warung nganjuk hiji',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/scan_product');
                  },
                  hoverColor: Colors.red,
                  child: Container(
                    width: 75.w,
                    height: 13.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.pink,
                          Colors.red,
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
                    child: Row(
                      children: [
                        SizedBox(width: 6.w),
                        Image.asset(
                          'asset/qr-code-scan.png',
                          width: 15.w,
                          height: 15.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Center(
                          child: Text(
                            "Scann",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/add_product');
                  },
                  hoverColor: Colors.orange,
                  child: Container(
                    width: 75.w,
                    height: 13.h,
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
                    child: Row(
                      children: [
                        SizedBox(width: 6.w),
                        Image.asset(
                          'asset/product.png',
                          width: 15.w,
                          height: 15.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Data Produk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                InkWell(
                  onTap: () {},
                  hoverColor: Colors.green,
                  child: Container(
                    width: 75.w,
                    height: 13.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.lightGreen,
                          Colors.green,
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
                    child: Row(
                      children: [
                        SizedBox(width: 6.w),
                        Image.asset(
                          'asset/history-book.png',
                          width: 15.w,
                          height: 15.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Histori Penjualan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                InkWell(
                  onTap: () {},
                  hoverColor: Colors.purple,
                  child: Container(
                    width: 75.w,
                    height: 13.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.blue,
                          Colors.purple,
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
                    child: Row(
                      children: [
                        SizedBox(width: 6.w),
                        Image.asset(
                          'asset/financial-profit.png',
                          width: 15.w,
                          height: 15.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "Statistik Keuangan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
