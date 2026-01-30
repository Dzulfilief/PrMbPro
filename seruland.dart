import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  print('=== TIKET SERULAND ===');

  stdout.write('Masukkan Usia: ');
  int usia = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  stdout.write('Apakah Akhir Pekan? (y/n): ');
  bool isAkhirPekan = (stdin.readLineSync()?.toLowerCase() == 'y');

  stdout.write('Punya Member Card? (y/n): ');
  bool punyaMemberCard = (stdin.readLineSync()?.toLowerCase() == 'y');

  String kategori = "";
  double hargaDasar = 0;

  if (usia < 6) {
    kategori = "Anak-anak (Gratis)";
    hargaDasar = 0;
  } else {
    if (usia <= 17) {
      kategori = "Pelajar";
      hargaDasar = 40000;
    } else {
      if (usia <= 60) {
        kategori = "Dewasa";
        hargaDasar = 60000;
      } else {
        kategori = "Lansia";
        hargaDasar = 35000;
      }
    }
  }

  double hargaProses = hargaDasar;

  if (isAkhirPekan) {
    hargaProses = hargaProses + (hargaProses * 0.20);
  }

  double nominalDiskon = 0;
  if (punyaMemberCard && hargaDasar > 0) {
    nominalDiskon = hargaProses * 0.10;
  }

  double totalAkhir = hargaProses - nominalDiskon;

  if (hargaDasar > 0 && totalAkhir < 30000) {
    totalAkhir = 30000;
  }

  print('\n--- Rincian Biaya ---');
  print('Kategori      : $kategori');
  print('Harga Awal    : Rp ${hargaDasar.toInt()}');

  if (isAkhirPekan && hargaDasar > 0) {
    print('Weekend (+20%): Rp ${(hargaProses).toInt()}');
  }

  if (nominalDiskon > 0) {
    print('Member (-10%) : -Rp ${nominalDiskon.toInt()}');
  }

  if (hargaDasar > 0 &&
      totalAkhir == 30000 &&
      (hargaProses - nominalDiskon) < 30000) {
    print('Note          : Berlaku Minimum Charge');
  }

  print('---------------------');
  print('Total Bayar   : Rp ${totalAkhir.toInt()}');
}
