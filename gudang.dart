import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  Map<String, Map<String, dynamic>> gudang = {
    'A01': {'nama': 'Earphone', 'stok': 12, 'harga': 99000},
    'B02': {'nama': 'Smartphone', 'stok': 5, 'harga': 3500000},
    'C03': {'nama': 'Kabel USB', 'stok': 20, 'harga': 25000},
    'D04': {'nama': 'Powerbank', 'stok': 8, 'harga': 250000},
    'E05': {'nama': 'Laptop', 'stok': 3, 'harga': 7500000},
  };

  bool running = true;

  while (running) {
    print('\n=== APLIKASI GUDANG GAWAI ===');
    print('1. Cari Barang');
    print('2. Update Stok');
    print('3. Daftar Barang Mahal (>200k)');
    print('4. Cetak Semua Data');
    print('0. Keluar');
    stdout.write('Pilih menu: ');

    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        stdout.write('Masukkan Kode Barang: ');
        String kode = stdin.readLineSync()?.toUpperCase() ?? '';
        if (gudang.containsKey(kode)) {
          var item = gudang[kode];
          print('\nDetail Barang:');
          print('Nama : ${item?['nama']}');
          print('Stok : ${item?['stok']}');
          print('Harga: Rp ${item?['harga']}');
        } else {
          print('\n[Error] Kode barang tidak ditemukan.');
        }
        break;

      case '2':
        stdout.write('Masukkan Kode Barang: ');
        String kode = stdin.readLineSync()?.toUpperCase() ?? '';

        if (gudang.containsKey(kode)) {
          stdout.write('Masukkan perubahan stok (+/-): ');
          int perubahan = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

          int stokLama = gudang[kode]?['stok'] as int;
          int stokBaru = stokLama + perubahan;

          if (stokBaru < 0) {
            print(
              '\n[Gagal] Stok tidak boleh negatif. Stok saat ini: $stokLama',
            );
          } else {
            gudang[kode]?['stok'] = stokBaru;
            print('\n[Sukses] Stok diperbarui. Stok sekarang: $stokBaru');
          }
        } else {
          print('\n[Error] Kode barang tidak ditemukan.');
        }
        break;

      case '3':
        print('\n--- Barang Mahal (> Rp 200.000) ---');
        bool ada = false;
        gudang.forEach((kode, item) {
          int harga = item['harga'] as int;
          if (harga > 200000) {
            print('[$kode] ${item['nama']} - Rp $harga');
            ada = true;
          }
        });
        if (!ada) print('Tidak ada barang mahal.');
        break;

      case '4':
        print('\n--- Data Gudang Lengkap ---');
        for (var kode in gudang.keys) {
          var item = gudang[kode];
          print('Kode: $kode | Nama: ${item?['nama']}');
        }
        break;

      case '0':
        running = false;
        print('Program selesai.');
        break;

      default:
        print('Pilihan tidak valid.');
    }
  }
}
