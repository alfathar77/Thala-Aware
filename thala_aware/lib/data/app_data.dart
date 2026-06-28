// Ini adalah file untuk menyimpan data statis (dummy data)

class AppData {
  
  // Data untuk artikel
  static final Map<String, String> _articles = {
    'mitos_fakta': """
MITOS: Thalassemia adalah penyakit menular.
FAKTA: Salah. Thalassemia adalah penyakit genetik (keturunan) yang diwariskan dari orang tua, bukan infeksi.

MITOS: Pembawa sifat Thalassemia (Minor) adalah orang yang sakit-sakitan.
FAKTA: Salah. Pembawa sifat hidup sehat, normal, tidak bergejala, dan tidak butuh transfusi darah.

MITOS: Thalassemia bisa disembuhkan dengan jamu atau obat herbal.
FAKTA: Salah. Thalassemia Major membutuhkan transfusi darah rutin seumur hidup atau transplantasi sumsum tulang.
""",
    
    'major_minor': """
Thalassemia adalah penyakit kelainan darah merah. Ada dua jenis utama yang perlu Anda ketahui:

1. Thalassemia Major
Ini adalah kondisi yang serius. Terjadi ketika seseorang mewarisi DUA gen Thalassemia (satu dari ayah, satu dari ibu). 
Penderitanya tidak bisa memproduksi hemoglobin yang cukup, sehingga sel darah merahnya mudah hancur (anemia berat).
Gejalanya muncul sejak bayi, seperti pucat, lemas, dan perut membuncit.
PERAWATAN: Penderita Thalassemia Major membutuhkan transfusi darah rutin SEUMUR HIDUP (setiap 2-4 minggu) untuk bertahan hidup.

2. Thalassemia Minor (Pembawa Sifat)
Ini BUKAN penyakit, melainkan kondisi genetik. Terjadi ketika seseorang hanya mewarisi SATU gen Thalassemia.
Individu ini SEHAT, NORMAL, hidup produktif, dan seringkali tidak tahu dirinya adalah pembawa sifat.
MEREKA TIDAK BUTUH TRANSFUSI.
MASALAHNYA: Jika seorang pembawa sifat menikah dengan sesama pembawa sifat, ada risiko 25% anak mereka menderita Thalassemia Major. Inilah mengapa skrining sangat penting.
""",
    
    'proses_skrining': """
Proses skrining Thalassemia sangat sederhana dan tidak perlu ditakuti. Tujuan utamanya adalah untuk mengetahui apakah Anda seorang pembawa sifat atau tidak.

Prosesnya disebut "Tes Hb-Elektroforesis" (Analisis Hemoglobin).

1. Pengambilan Sampel
Dokter atau petugas lab akan mengambil sedikit sampel darah Anda melalui jarum suntik, sama seperti tes darah biasa.

2. Analisis di Laboratorium
Sampel darah Anda akan dianalisis di lab untuk melihat jenis dan kadar hemoglobin dalam sel darah merah Anda.

3. Hasil
Hasilnya akan menunjukkan apakah Anda "Normal", "Thalassemia Minor (Pembawa Sifat)", atau (jarang terjadi jika Anda tidak bergejala) "Thalassemia Major/Intermedia".

Siapa yang perlu tes?
Idealnya, semua orang. Namun, yang paling diutamakan adalah pasangan yang akan menikah atau pasangan yang sedang merencanakan kehamilan.
"""
  };

  // Data untuk lokasi (dummy)
  // Untuk proyek UAS, data hardcode ini sudah cukup.
  static final List<Map<String, String>> _locations = [
    {
      'nama': 'PMI Kota Jakarta Pusat',
      'alamat': 'Jl. Kramat Raya No.47, RT.2/RW.2, Kramat',
      'kota': 'Jakarta Pusat'
    },
    {
      'nama': 'Laboratorium Prodia Bandung',
      'alamat': 'Jl. Wastukencana No.38, Tamansari',
      'kota': 'Bandung'
    },
    {
      'nama': 'RSUP Dr. Sardjito Yogyakarta',
      'alamat': 'Jl. Kesehatan Jl. Bhinneka Tunggal Ika, Sinduadi, Mlati',
      'kota': 'Yogyakarta'
    },
    {
      'nama': 'PMI Kota Surabaya',
      'alamat': 'Jl. Embong Ploso No.7-15, Embong Kaliasin',
      'kota': 'Surabaya'
    },
    {
      'nama': 'RS Cipto Mangunkusumo (RSCM) - Poli Thalassemia',
      'alamat': 'Jl. Pangeran Diponegoro No.71, Senen',
      'kota': 'Jakarta Pusat'
    },
  ];

  // Fungsi untuk mengambil data
  static String getArticleContent(String key) {
    return _articles[key] ?? 'Konten tidak ditemukan.';
  }

  static List<Map<String, String>> getLocations() {
    return _locations;
  }
}