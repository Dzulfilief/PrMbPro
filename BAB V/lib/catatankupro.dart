import 'package:flutter/material.dart';

void main() {
  runApp(const CatatankuProApp());
}

class CatatankuProApp extends StatelessWidget {
  const CatatankuProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CatatanKu Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // Set rute awal ke Login Page
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.note_alt_outlined,
                size: 80,
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              const Text(
                "CatatanKu Pro",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Masuk untuk mengelola catatanmu"),
              const SizedBox(height: 32),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // SOAL: Login -> Home (gunakan pushReplacement)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text("Masuk"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================
// 2. HALAMAN HOME (Daftar Catatan)
// ==============================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List untuk menyimpan data catatan sementara
  final List<String> _notes = [];

  // Fungsi untuk navigasi ke halaman tambah dan menunggu hasil
  void _navigateToAddPage() async {
    // SOAL: Menerima data antar layar (pop result)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );

    // Jika ada data yang dikembalikan, tambahkan ke list
    if (result != null && result is String) {
      setState(() {
        _notes.add(result);
      });

      // Tampilkan SnackBar sebagai feedback
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Catatan "$result" ditambahkan!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Catatan"),
        backgroundColor: Colors.indigo.shade50,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout kembali ke Login (pushReplacement)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      // SOAL: Home -> daftar catatan (ListView)
      body: _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.library_books, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada catatan",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(_notes[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _notes.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      // SOAL: FAB "Tambah"
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==============================
// 3. HALAMAN FORM (Tambah Catatan)
// ==============================
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _controller = TextEditingController();

  void _submitData() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      // SOAL: Mengirim data kembali ke halaman asal (Navigator.pop)
      Navigator.pop(context, text);
    } else {
      // Validasi sederhana
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Isi catatan tidak boleh kosong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Catatan Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // SOAL: Event Handling (onSubmitted)
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Isi Catatan",
                border: OutlineInputBorder(),
                hintText: "Contoh: Belajar Routing Flutter",
              ),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _submitData, // SOAL: Event Handling (onPressed)
                    child: const Text("Simpan"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
