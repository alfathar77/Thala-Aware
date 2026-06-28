import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String statusAnda;
  final String statusPasangan;

  const ResultScreen({
    super.key,
    required this.statusAnda,
    required this.statusPasangan,
  });

  // Fungsi untuk membangun konten hasil berdasarkan input
  Widget _buildResultContent(BuildContext context) {
    Color cardColor;
    String title;
    String description;
    IconData icon;

    // --- LOGIKA KALKULATOR LENGKAP ---

    // 1. KONDISI: ADA YANG BELUM TAHU
    if (statusAnda == 'belum_tahu' || statusPasangan == 'belum_tahu') {
      cardColor = Colors.orange[100]!;
      icon = Icons.help_outline;
      title = 'RISIKO TIDAK DIKETAHUI';
      description = 'Karena status salah satu/keduanya belum diketahui, risiko tidak bisa diprediksi.\n\nSangat disarankan untuk tes darah (Hb-Elektroforesis) di laboratorium.';
    }
    
    // 2. KONDISI: SESAMA MAYOR (SANGAT BERBAHAYA)
    else if (statusAnda == 'mayor' && statusPasangan == 'mayor') {
      cardColor = Colors.red[200]!;
      icon = Icons.warning_amber_rounded;
      title = 'RISIKO SANGAT TINGGI (100%)';
      description = 'Kedua orang tua Thalassemia Mayor.\n\n⚠️ 100% kemungkinan anak lahir dengan Thalassemia Mayor.\nHarap konsultasi serius dengan dokter.';
    }

    // 3. KONDISI: MAYOR + MINOR (BAHAYA TINGGI)
    else if ((statusAnda == 'mayor' && statusPasangan == 'pembawa_sifat') || 
             (statusAnda == 'pembawa_sifat' && statusPasangan == 'mayor')) {
      cardColor = Colors.red[100]!;
      icon = Icons.warning;
      title = 'RISIKO TINGGI (50%)';
      description = 'Kombinasi Mayor + Pembawa Sifat.\n\n⚠️ 50% kemungkinan anak Thalassemia Mayor.\nℹ️ 50% kemungkinan anak Pembawa Sifat.';
    }

    // 4. KONDISI: SESAMA MINOR (RISIKO KLASIK)
    else if (statusAnda == 'pembawa_sifat' && statusPasangan == 'pembawa_sifat') {
      cardColor = Colors.red[50]!; // Merah agak muda
      icon = Icons.warning_amber;
      title = 'RISIKO SEDANG (25%)';
      description = 'Kombinasi sesama Pembawa Sifat.\n\n⚠️ 25% kemungkinan anak Thalassemia Mayor.\nℹ️ 50% kemungkinan anak Pembawa Sifat.\n✅ 25% kemungkinan anak Normal.';
    }

    // 5. KONDISI: MAYOR + NORMAL (AMAN DARI MAYOR, TAPI PASTI CARRIER)
    else if ((statusAnda == 'mayor' && statusPasangan == 'normal') || 
             (statusAnda == 'normal' && statusPasangan == 'mayor')) {
      cardColor = Colors.blue[100]!;
      icon = Icons.info;
      title = 'TIDAK ADA RISIKO MAYOR';
      description = 'Kombinasi Mayor + Normal.\n\n✅ 0% risiko anak Thalassemia Mayor.\nℹ️ Tapi 100% anak akan menjadi Pembawa Sifat (Minor).';
    }

    // 6. KONDISI LAINNYA (NORMAL + NORMAL / NORMAL + MINOR) -> AMAN
    else {
      cardColor = Colors.green[100]!;
      icon = Icons.check_circle;
      title = 'AMAN / RISIKO RENDAH';
      description = 'Tidak ada risiko anak lahir dengan Thalassemia Mayor pada kombinasi ini.\n\nAnak mungkin menjadi pembawa sifat atau normal sepenuhnya.';
    }

    return Card(
      color: cardColor,
      margin: const EdgeInsets.all(16),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: Colors.black87),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Perkiraan Risiko'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildResultContent(context),
            const SizedBox(height: 24),
            const Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'DISCLAIMER: Aplikasi ini adalah kalkulator probabilitas, BUKAN alat diagnosis medis. Diagnosis pasti HANYA bisa didapatkan melalui tes darah (skrining) di laboratorium.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}