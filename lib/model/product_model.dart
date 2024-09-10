class Product {
  String? produkID;
  String? namaProduk;
  int? jumlahProduk;
  double? hargaProduk;

  Product({
    required this.produkID,
    required this.namaProduk,
    required this.jumlahProduk,
    required this.hargaProduk,
  });

  Map<String, dynamic> toMap() {
    return {
      'produkID': produkID,
      'namaProduk': namaProduk,
      'jumlahProduk': jumlahProduk,
      'hargaProduk': hargaProduk,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      produkID: map['produkID'],
      namaProduk: map['namaProduk'],
      jumlahProduk: map['jumlahProduk'],
      hargaProduk: map['hargaProduk'],
    );
  }
}
