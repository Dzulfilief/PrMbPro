import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar\n Nim : 32602300087\n");
  print('=== APLIKASI KURIR KITA ===');
  print('Layanan Tersedia:');
  print('[S] Same Day');
  print('[E] Express');
  print('[R] Reguler');
  print('[H] Hemat');
  print('---------------------------');

  // --- 1. INPUT (Req A: 1 Karakter) ---
  stdout.write('Masukkan Kode Layanan (S/E/R/H): ');
  // Baca input, ambil karakter pertama, dan ubah ke huruf besar (Uppercase)
  // agar input 's' kecil tetap terbaca sebagai 'S'.
  String input = stdin.readLineSync()?.toUpperCase() ?? '';
  String kode = input.isNotEmpty ? input[0] : '';

  // Variabel untuk menampung hasil pemetaan
  String namaLayanan = '';
  String estimasi = '';
  int biaya = 0;
  bool kodeValid = true;

  // --- 2. LOGIKA SWITCH (Req B & Wajib) ---
  switch (kode) {
    case 'S':
      namaLayanan = 'Same Day';
      estimasi = 'Tiba hari ini';
      biaya = 25000;
      break;
    case 'E':
      namaLayanan = 'Express';
      estimasi = '1-2 Hari';
      biaya = 15000;
      break;
    case 'R':
      namaLayanan = 'Reguler';
      estimasi = '2-4 Hari';
      biaya = 8000;
      break;
    case 'H':
      namaLayanan = 'Hemat';
      estimasi = '3-7 Hari';
      biaya = 0; // Gratis ongkir tambahan
      break;
    // --- 3. DEFAULT CASE (Req C) ---
    default:
      kodeValid = false;
      print('\n[Error] Kode layanan "$kode" tidak dikenali.');
  }

  // --- OUTPUT ---
  if (kodeValid) {
    print('\n--- Rincian Pesanan ---');
    print('Layanan        : $namaLayanan');
    print('Estimasi Waktu : $estimasi');
    print('Biaya Tambahan : Rp $biaya');
    print('-----------------------');
  }
}
