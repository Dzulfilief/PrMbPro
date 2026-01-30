import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  Map<String, Map<String, dynamic>> katalog = {
    "M01": {
      "nama": "Air Mineral 600ml",
      "kategori": "minuman",
      "harga": 5000,
      "stok": 40,
    },
    "S11": {
      "nama": "Keripik Kentang",
      "kategori": "snack",
      "harga": 14000,
      "stok": 25,
    },
    "H07": {
      "nama": "Sabun Mandi",
      "kategori": "home",
      "harga": 9000,
      "stok": 30,
    },
    "S12": {
      "nama": "Coklat Batang",
      "kategori": "snack",
      "harga": 20000,
      "stok": 10,
    },
    "M02": {
      "nama": "Jus Jeruk",
      "kategori": "minuman",
      "harga": 10000,
      "stok": 5,
    },
  };

  Map<String, int> keranjang = {"M01": 7, "S12": 4, "S11": 10, "M02": 10};

  bool isMember = true;
  double totalBelanja = 0;
  double totalSnack = 0;
  double potonganSnack = 0;
  double potonganMember = 0;
  String voucher = "-";

  print('=== STRUK BELANJA HEMART ===');
  print('Status Member: $isMember\n');

  for (var entry in keranjang.entries) {
    String kode = entry.key;
    int qtyMinta = entry.value;

    if (katalog.containsKey(kode)) {
      var item = katalog[kode]!;
      int stok = item['stok'] as int;
      String nama = item['nama'] as String;
      String kategori = item['kategori'] as String;
      int harga = item['harga'] as int;

      if (stok >= qtyMinta) {
        int qtyBayar = qtyMinta;
        String notePromo = "-";

        if (kategori == "minuman") {
          if (qtyMinta >= 6) {
            int gratis = qtyMinta ~/ 6;
            qtyBayar = qtyMinta - gratis;
            notePromo = "Beli 5 Gratis 1";
          }
        }

        double subtotal = (qtyBayar * harga).toDouble();
        totalBelanja += subtotal;

        if (kategori == "snack") {
          totalSnack += subtotal;
        }

        katalog[kode]!['stok'] = stok - qtyMinta;

        print('Item: $nama ($kode)');
        print('Qty : $qtyMinta | Bayar: $qtyBayar | Promo: $notePromo');
        print('Subtotal: Rp ${subtotal.toInt()}');
        print('--------------------------------');
      } else {
        print('Item: $nama ($kode)');
        print('[Gagal] Stok tidak cukup. Diminta: $qtyMinta, Tersedia: $stok');
        print('--------------------------------');
      }
    }
  }

  if (totalSnack > 50000) {
    potonganSnack = totalSnack * 0.10;
  }

  double totalSetelahDiskonBarang = totalBelanja - potonganSnack;
  double totalAkhir = totalSetelahDiskonBarang;

  if (totalSetelahDiskonBarang > 150000) {
    if (isMember) {
      potonganMember = totalSetelahDiskonBarang * 0.05;
      totalAkhir -= potonganMember;
    } else {
      if (totalSetelahDiskonBarang > 200000) {
        voucher = "Voucher Rp 10.000 (Next Visit)";
      }
    }
  }

  print('\n=== RINGKASAN PEMBAYARAN ===');
  print('Total Awal       : Rp ${totalBelanja.toInt()}');
  if (potonganSnack > 0) {
    print('Diskon Snack (10%): -Rp ${potonganSnack.toInt()}');
  }
  print('Total Sementara  : Rp ${totalSetelahDiskonBarang.toInt()}');

  if (potonganMember > 0) {
    print('Diskon Member (5%): -Rp ${potonganMember.toInt()}');
  }

  print('TOTAL BAYAR      : Rp ${totalAkhir.toInt()}');

  if (voucher != "-") {
    print('Bonus            : $voucher');
  }
}
