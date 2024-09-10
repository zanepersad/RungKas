import 'package:flutter/cupertino.dart';
import 'package:test_1/view/product/add_data_produk.dart';
import 'package:test_1/view/home.dart';
import 'package:test_1/view/login.dart';
import 'package:test_1/view/product/data_produk.dart';
import 'package:test_1/view/scan/scan_produk.dart';

class AppRoute {
  static const String initialPagerRoute = '/';

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const Login(),
    '/home': (context) => const Home(),
    '/add_product': (context) => const AddDataProduct(),
    '/data_product': (context) => const dataProduct(),
    '/scan_product': (context) => const Scanner(),
    // Add more routes here
  };
}
