import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CatatanKu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ==============================
// 1. HALAMAN LOGIN
// ==============================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Masuk",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // a. Text Judul
            const Text(
              "Selamat Datang, Alief!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // c. Dua TextField
            const TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            // c. TextButton Lupa Password (Rata Kanan)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Lupa password?"),
              ),
            ),
            const SizedBox(height: 24),

            // d. Baris Tombol
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Lewati"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke Halaman Beranda
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Masuk"),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ==============================
// 2. HALAMAN BERANDA
// ==============================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fungsi helper untuk menampilkan SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  // Fungsi untuk menampilkan BottomSheet
  void _showAddNoteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Supaya tidak tertutup keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambah Catatan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup sheet
                      _showSnackBar(context, "Item ditambahkan");
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CatatanKu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Kecil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rekomendasi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(onPressed: () {}, child: const Text("Lihat semua")),
            ],
          ),

          // Daftar Kartu Catatan
          _buildNoteCard(
            context,
            "Belajar Row & Column",
            "Pahami sumbu utama dan silang, serta Expanded/Flexible agar layout responsif.",
            Colors.teal.shade50,
            Icons.grid_view,
          ),
          _buildNoteCard(
            context,
            "Button di Flutter",
            "Gunakan Filled untuk aksi utama, Outlined untuk sekunder, Text untuk ringan.",
            Colors.blue.shade50,
            Icons.smart_button,
          ),
          _buildNoteCard(
            context,
            "Text & Overflow",
            "Atur maxLines dan overflow agar teks tidak meledak, gunakan softWrap untuk membungkus.",
            Colors.orange.shade50,
            Icons.text_fields,
          ),
        ],
      ),

      // d. Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(
    BuildContext context,
    String title,
    String desc,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // b. Kiri: Avatar Kecil
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: Colors.black87),
              ),
              const SizedBox(width: 12),

              // b. Kanan: Column Teks
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1) Judul: MaxLines 1, Ellipsis
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // 2) Deskripsi: MaxLines 2, Ellipsis
                    Text(
                      desc,
                      style: TextStyle(color: Colors.grey.shade800),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // c. Aksi Kartu: Tiga IconButton
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _actionButton(context, Icons.edit, "Edit ditekan"),
              const SizedBox(width: 8),
              _actionButton(context, Icons.delete, "Hapus ditekan"),
              const SizedBox(width: 8),
              _actionButton(context, Icons.share, "Bagikan ditekan"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String msg) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon, color: Colors.grey.shade700),
        onPressed: () => _showSnackBar(context, msg),
      ),
    );
  }
}
