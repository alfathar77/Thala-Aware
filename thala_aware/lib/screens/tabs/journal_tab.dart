import 'package:flutter/material.dart';
import 'package:thala_aware/helpers/api_service.dart';
import 'package:thala_aware/models/screening_log.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class JournalTab extends StatefulWidget {
  const JournalTab({super.key});

  @override
  State<JournalTab> createState() => _JournalTabState();
}

class _JournalTabState extends State<JournalTab> {
  final ApiService _apiService = ApiService();
  
  // --- INI YANG TADI KURANG (DEKLARASI CONTROLLER) ---
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Load data dari API
  Future<List<ScreeningLog>> _loadLogs() async {
    return await _apiService.getLogs();
  }

  // --- FUNGSI SIMPAN JURNAL (DENGAN NAMA USER) ---
  Future<void> _saveJournal() async {
    // 1. Ambil nama user dari memori HP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name') ?? 'Guest'; // Default 'Guest' jika kosong

    // 2. Buat objek data baru
    final newLog = ScreeningLog(
      username: userName, // Pakai nama user yang login
      date: DateTime.now().toString().substring(0, 10), // Ambil tanggal hari ini
      location: _locationController.text,
      result: _resultController.text,
      notes: _notesController.text,
    );

    // 3. Kirim ke API
    bool success = await _apiService.insertLog(newLog);

    // 4. Jika sukses, bersihkan form dan tutup dialog
    if (success) {
      if (mounted) { // Cek apakah layar masih aktif
        _locationController.clear();
        _resultController.clear();
        _notesController.clear();
        Navigator.pop(context); // Tutup Dialog
        setState(() {}); // Refresh Tampilan
      }
    } else {
      // Opsional: Tampilkan pesan error jika gagal
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan data. Cek koneksi internet/XAMPP.')),
        );
      }
    }
  }

  // Dialog Form Tambah Data
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Catat Hasil Skrining'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Lokasi (Misal: PMI)'),
                ),
                TextField(
                  controller: _resultController,
                  decoration: const InputDecoration(labelText: 'Hasil (Misal: Hb 12)'),
                ),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Catatan Tambahan'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                // Panggil fungsi _saveJournal saat tombol ditekan
                _saveJournal(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<ScreeningLog>>(
        future: _loadLogs(),
        builder: (context, snapshot) {
          // Handle Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Handle Error
          if (snapshot.hasError) {
            return Center(child: Text("Belum ada data / Gagal konek ke XAMPP. \nError: ${snapshot.error}"));
          }
          
          final logs = snapshot.data!;
          if (logs.isEmpty) {
            return const Center(child: Text("Belum ada riwayat skrining."));
          }
          
          // Tampilkan List Data
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal[100],
                    child: Text(
                      log.username.isNotEmpty ? log.username[0].toUpperCase() : 'U',
                      style: TextStyle(color: Colors.teal[800], fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(log.location, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Oleh: ${log.username}"), // Menampilkan nama user
                      Text("${log.date} • Hasil: ${log.result}"),
                      if(log.notes.isNotEmpty) Text("Note: ${log.notes}", style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // Hapus via API
                      await _apiService.deleteLog(log.id!);
                      setState(() {}); // Refresh setelah hapus
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}