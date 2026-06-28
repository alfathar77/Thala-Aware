import 'package:flutter/material.dart';
import 'package:thala_aware/data/app_data.dart'; // Import data lokasi

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  // Ambil data lokasi dari AppData
  final List<Map<String, String>> _allLocations = AppData.getLocations();
  List<Map<String, String>> _filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Awalnya, tampilkan semua lokasi
    _filteredLocations = _allLocations;
    _searchController.addListener(_filterLocations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLocations() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLocations = _allLocations.where((location) {
        final nama = location['nama']?.toLowerCase() ?? '';
        final kota = location['kota']?.toLowerCase() ?? '';
        return nama.contains(query) || kota.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direktori Lokasi Skrining'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan nama atau kota...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          
          // Daftar Hasil
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLocations.length,
              itemBuilder: (context, index) {
                final location = _filteredLocations[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.local_hospital, color: Colors.red),
                    title: Text(location['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${location['alamat']}\n${location['kota']}"),
                    isThreeLine: true,
                    // Opsional: Tambahkan tombol untuk membuka peta
                    // trailing: IconButton(
                    //   icon: Icon(Icons.map, color: Colors.teal),
                    //   onPressed: () {
                    //     // Gunakan package url_launcher untuk membuka alamat di peta
                    //   },
                    // ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}