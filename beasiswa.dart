import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar\nNim : 32602300087\n");
  print('=== SELEKSI BEASISWA TALENTA ===');

  // --- 1. INPUT DATA ---
  // Menggunakan tryParse agar program tidak crash kalau input kosong/huruf
  stdout.write('Masukkan Nilai Rata-rata (0-100): ');
  int nilaiRata2 = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  stdout.write('Masukkan Pendapatan Orang Tua (Rp): ');
  int pendapatanOrtu = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  stdout.write('Apakah punya prestasi? (y/n): ');
  String inputPrestasi = stdin.readLineSync()?.toLowerCase() ?? 'n';
  bool punyaPrestasi = (inputPrestasi == 'y');

  String tingkatPrestasi = "";
  if (punyaPrestasi) {
    stdout.write('Tingkat Prestasi (kota/provinsi/nasional): ');
    tingkatPrestasi = stdin.readLineSync()?.toLowerCase() ?? "";
  }

  // --- 2. LOGIKA NESTED IF-ELSE (Sesuai Tugas B) ---
  String status = "";
  String alasan = "";

  // Outer If: Cek Syarat Utama (Nilai)
  if (nilaiRata2 >= 85) {
    // Inner If 1: Cek "Diterima Penuh" (Prestasi Minimal Provinsi)
    // Logika: 'nasional' juga dianggap di atas 'provinsi', jadi kita masukkan.
    if (punyaPrestasi &&
        (tingkatPrestasi == 'provinsi' || tingkatPrestasi == 'nasional')) {
      status = "Diterima Penuh";
      alasan =
          "Nilai memenuhi standar & memiliki prestasi tingkat $tingkatPrestasi.";
    }
    // Inner If 2: Cek "Diterima Parsial"
    // Syarat: Pendapatan < 5jt ATAU Prestasi Kota
    else if (pendapatanOrtu < 5000000 ||
        (punyaPrestasi && tingkatPrestasi == 'kota')) {
      status = "Diterima Parsial";

      // Detailkan alasannya biar jelas (Optional tapi bagus buat laporan)
      if (pendapatanOrtu < 5000000) {
        alasan =
            "Nilai memenuhi standar & pendapatan orang tua di bawah Rp 5 juta.";
      } else {
        alasan = "Nilai memenuhi standar & memiliki prestasi tingkat kota.";
      }
    }
    // Inner Else: Nilai Oke, tapi syarat ekonomi/prestasi gagal
    else {
      status = "Tidak Diterima";
      alasan =
          "Nilai cukup, namun pendapatan tinggi & tidak ada prestasi yang memadai.";
    }
  } else {
    // Outer Else: Nilai Hancur
    status = "Tidak Diterima";
    alasan = "Nilai rata-rata ($nilaiRata2) tidak mencapai batas minimum 85.";
  }

  // --- 3. OUTPUT ---
  print('\n----------------------------------');
  print('KEPUTUSAN JURI');
  print('----------------------------------');
  print('Status Akhir : $status');
  print('Alasan       : $alasan');
  print('----------------------------------');
}
