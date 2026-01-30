import 'dart:io';

void main() {
  print("Nama : Alief Dzulfikar");
  print("NIM  : 32602300087");
  print("-------------------------------\n");

  List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  List<int> aqiMingguan = [45, 85, 120, 160, 40, 48, 180];
  List<bool> acaraLuarRuang = [false, true, false, false, true, false, true];

  int totalAQI = 0;
  int streakBaik = 0;
  int maxStreak = 0;

  Map<String, int> kategoriCount = {
    "Baik": 0,
    "Sedang": 0,
    "Tidak Sehat Sensitif": 0,
    "Tidak Sehat": 0,
  };

  print('=== LAPORAN HARIAN KUALITAS UDARA ===');
  print('Hari\t | AQI | Kategori\t\t | Rekomendasi');
  print('---------------------------------------------------------------');

  for (int i = 0; i < aqiMingguan.length; i++) {
    int nilai = aqiMingguan[i];
    bool adaAcara = acaraLuarRuang[i];
    String namaHari = hari[i];

    totalAQI += nilai;

    String kategori = "";
    String rekomendasi = "-";

    if (nilai <= 50) {
      kategori = "Baik";
      streakBaik++;
    } else {
      if (streakBaik > maxStreak) {
        maxStreak = streakBaik;
      }
      streakBaik = 0;

      if (nilai <= 100) {
        kategori = "Sedang";
      } else {
        if (nilai <= 150) {
          kategori = "Tidak Sehat Sensitif";
        } else {
          kategori = "Tidak Sehat";
        }
      }
    }

    if (kategori == "Baik") {
      kategoriCount["Baik"] = (kategoriCount["Baik"] ?? 0) + 1;
    } else if (kategori == "Sedang") {
      kategoriCount["Sedang"] = (kategoriCount["Sedang"] ?? 0) + 1;
      if (adaAcara) {
        rekomendasi = "Masker dianjurkan";
      }
    } else if (kategori == "Tidak Sehat Sensitif") {
      kategoriCount["Tidak Sehat Sensitif"] =
          (kategoriCount["Tidak Sehat Sensitif"] ?? 0) + 1;
    } else {
      kategoriCount["Tidak Sehat"] = (kategoriCount["Tidak Sehat"] ?? 0) + 1;
      if (i >= 5) {
        // Sabtu (5) atau Minggu (6)
        rekomendasi = "Pertimbangkan di rumah";
      }
    }

    print(
      '${namaHari.padRight(7)} | ${nilai.toString().padRight(3)} | ${kategori.padRight(21)} | $rekomendasi',
    );
  }

  if (streakBaik > maxStreak) {
    maxStreak = streakBaik;
  }

  double rataRata = totalAQI / aqiMingguan.length;

  print('---------------------------------------------------------------');
  print('\n=== RINGKASAN MINGGUAN ===');
  print('Rata-rata AQI      : ${rataRata.toStringAsFixed(2)}');
  print('Streak "Baik"      : $maxStreak hari berturut-turut');
  print('\nJumlah Hari per Kategori:');
  kategoriCount.forEach((k, v) {
    if (v > 0) print('- $k: $v hari');
  });
}
