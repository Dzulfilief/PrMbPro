import 'dart:io';

void main() {
  const double hargaEspresso = 25000;
  const double hargaLatte = 30000;
  const double hargaTeh = 15000;
  const double tarifPajak = 0.10;

  final DateTime waktuCetak = DateTime.now();

  print('=== APLIKASI KASIR KOPI KITA ===');
  print('--------------------------------');

  stdout.write('Masukkan jumlah Espresso : ');
  int qtyEspresso = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  stdout.write('Masukkan jumlah Latte    : ');
  int qtyLatte = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  stdout.write('Masukkan jumlah Teh      : ');
  int qtyTeh = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  double subtotal =
      (qtyEspresso * hargaEspresso) +
      (qtyLatte * hargaLatte) +
      (qtyTeh * hargaTeh);

  double nominalPajak = subtotal * tarifPajak;
  double totalAkhir = subtotal + nominalPajak;

  print('\n\n');
  print('==========================================');
  print('            STRUK PEMBELIAN               ');
  print('               KOPI KITA                  ');
  print('==========================================');
  print('Waktu Cetak: ${waktuCetak.toString().split('.')[0]}');
  print('------------------------------------------');

  if (qtyEspresso > 0)
    print('Espresso x $qtyEspresso \t: Rp ${qtyEspresso * hargaEspresso}');
  if (qtyLatte > 0)
    print('Latte    x $qtyLatte \t: Rp ${qtyLatte * hargaLatte}');
  if (qtyTeh > 0) print('Teh      x $qtyTeh \t: Rp ${qtyTeh * hargaTeh}');

  print('------------------------------------------');
  print('Subtotal       \t: Rp $subtotal');
  print('Pajak (10%)    \t: Rp $nominalPajak');
  print('------------------------------------------');
  print('TOTAL BAYAR    \t: Rp $totalAkhir');
  print('==========================================');
}
