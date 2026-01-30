import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  print('=== SISTEM REKAP TOKO BUKU BAHAGIA ===');

  List<int> penjualan = [5, 12, 8, 20, 3, 15, 10, 7];
  print('Data awal: $penjualan');

  String lagi = 'n';
  do {
    stdout.write('\nMasukkan jumlah buku terjual (angka): ');
    int? input = int.tryParse(stdin.readLineSync() ?? '');

    if (input != null && input >= 0) {
      penjualan.add(input);
      print('Data berhasil disimpan.');
    } else {
      print('[Error] Input tidak valid (harus angka positif).');
    }

    stdout.write('Tambah transaksi lagi? (y/n): ');
    lagi = stdin.readLineSync()?.toLowerCase() ?? 'n';
  } while (lagi == 'y');

  int totalBuku = 0;
  for (int i = 0; i < penjualan.length; i++) {
    totalBuku += penjualan[i];
  }
  double rataRata = totalBuku / penjualan.length;

  int max = penjualan[0];
  int min = penjualan[0];
  int index = 1;
  while (index < penjualan.length) {
    if (penjualan[index] > max) {
      max = penjualan[index];
    }
    if (penjualan[index] < min) {
      min = penjualan[index];
    }
    index++;
  }

  print('\n===================================');
  print('       RINGKASAN PENJUALAN         ');
  print('===================================');
  print('Total Transaksi   : ${penjualan.length}');
  print('Total Buku Terjual: $totalBuku');
  print('Rata-rata Penjualan: ${rataRata.toStringAsFixed(2)}');
  print('Penjualan Tertinggi: $max');
  print('Penjualan Terendah : $min');
  print('-----------------------------------');

  int startIdx = penjualan.length > 3 ? penjualan.length - 3 : 0;
  List<int> terakhir = penjualan.sublist(startIdx);

  print('3 Transaksi Terakhir: $terakhir');
  print('===================================');
}
