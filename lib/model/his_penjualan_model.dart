class HistoryPenjualan {
  String? namaPelanggan;
  String? namaProduk;
  int? totalJumlahProduk;
  double? totalHarga;
  HistoryPenjualan({
    required this.namaPelanggan,
    required this.namaProduk,
    required this.totalJumlahProduk,
    required this.totalHarga,
  });
  Map<String, dynamic> toMap() {
    return {
      'namaPelanggan': namaPelanggan,
      'namaProduk': namaProduk,
      'totalJumlahProduk': totalJumlahProduk,
      'totalHarga': totalHarga,
    };
  }

  factory HistoryPenjualan.fromMap(Map<String, dynamic> map) {
    return HistoryPenjualan(
      namaPelanggan: map['namaPelanggan'],
      namaProduk: map['namaProduk'],
      totalJumlahProduk: map['totalJumlahProduk'],
      totalHarga: map['totalHarga'],
    );
  }
}
