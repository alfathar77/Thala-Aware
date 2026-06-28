import 'package:flutter/material.dart';
import 'package:thala_aware/screens/details/result_screen.dart';
import 'package:thala_aware/helpers/api_service.dart'; // Import API
import 'package:shared_preferences/shared_preferences.dart'; // Import Prefs

class CalculatorTab extends StatefulWidget {
  const CalculatorTab({Key? key}) : super(key: key);

  @override
  _CalculatorTabState createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  final ApiService _apiService = ApiService();
  
  // Default value
  String _statusAnda = 'belum_tahu';
  String _statusPasangan = 'belum_tahu';

  // --- BAGIAN INI YANG ANDA CARI ---
  // Daftar Pilihan Dropdown (Sudah ditambahkan Mayor)
  final List<DropdownMenuItem<String>> _dropdownItems = [
    const DropdownMenuItem(value: 'belum_tahu', child: Text('Belum Tahu / Belum Tes')),
    const DropdownMenuItem(value: 'normal', child: Text('Normal (Sehat)')),
    const DropdownMenuItem(value: 'pembawa_sifat', child: Text('Pembawa Sifat (Minor)')),
    
    // Opsi Baru:
    const DropdownMenuItem(value: 'mayor', child: Text('Thalassemia Mayor')), 
  ];
  // ----------------------------------

  void _calculateRisk() async {
    // 1. Tentukan Label Risiko untuk disimpan ke Database
    String riskLabel = "Tidak Diketahui";
    
    if (_statusAnda == 'mayor' && _statusPasangan == 'mayor') {
      riskLabel = "Sangat Tinggi (100% Mayor)";
    } else if ((_statusAnda == 'mayor' && _statusPasangan == 'pembawa_sifat') || 
               (_statusAnda == 'pembawa_sifat' && _statusPasangan == 'mayor')) {
      riskLabel = "Tinggi (50% Mayor)";
    } else if (_statusAnda == 'pembawa_sifat' && _statusPasangan == 'pembawa_sifat') {
      riskLabel = "Tinggi (25% Mayor)";
    } else if ((_statusAnda == 'mayor' && _statusPasangan == 'normal') || 
               (_statusAnda == 'normal' && _statusPasangan == 'mayor')) {
      riskLabel = "Aman dari Mayor (100% Carrier)";
    } else if (_statusAnda == 'belum_tahu' || _statusPasangan == 'belum_tahu') {
      riskLabel = "Belum Diketahui";
    } else {
      riskLabel = "Rendah / Aman";
    }

    // 2. Simpan ke Database MySQL (History)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name') ?? 'Guest';

    // Panggil API (Abaikan hasil true/false, yang penting kirim)
    _apiService.saveCalculation(
      username: userName,
      userStatus: _statusAnda,
      partnerStatus: _statusPasangan,
      riskResult: riskLabel,
    );

    // 3. Pindah ke Layar Hasil
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            statusAnda: _statusAnda,
            statusPasangan: _statusPasangan,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kalkulator Risiko Genetik',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pilih status Anda dan pasangan. Data kalkulasi ini akan disimpan ke riwayat akun Anda.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 32),
          
          // Input 1: Status Anda
          Text('Status Anda:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _statusAnda,
            items: _dropdownItems,
            onChanged: (val) => setState(() => _statusAnda = val!),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
          const SizedBox(height: 24),

          // Input 2: Status Pasangan
          Text('Status Pasangan Anda:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _statusPasangan,
            items: _dropdownItems,
            onChanged: (val) => setState(() => _statusPasangan = val!),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
          const SizedBox(height: 40),

          // Tombol Aksi
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateRisk,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Lihat Risiko & Simpan Riwayat'),
            ),
          ),
        ],
      ),
    );
  }
}