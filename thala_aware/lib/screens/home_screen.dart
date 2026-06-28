import 'package:flutter/material.dart';
import 'package:thala_aware/screens/tabs/calculator_tab.dart';
import 'package:thala_aware/screens/tabs/education_tab.dart';
// 1. Import file JurnalTab (Pastikan file ini sudah dibuat ya!)
import 'package:thala_aware/screens/tabs/journal_tab.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Daftar widget (Tab) yang akan ditampilkan
  static const List<Widget> _widgetOptions = <Widget>[
    CalculatorTab(),
    EducationTab(),
    JournalTab(), // 2. Tambahkan JournalTab ke dalam daftar ini
  ];

  // Daftar judul untuk AppBar
  static const List<String> _widgetTitles = <String>[
    'Kalkulator Risiko',
    'Pusat Informasi',
    'Jurnal Riwayat', // 3. Tambahkan Judul untuk AppBar
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Mengambil judul sesuai index yang aktif
        title: Text(_widgetTitles.elementAt(_selectedIndex)),
      ),
      body: Center(
        // Menampilkan halaman sesuai index yang aktif
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Kalkulator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Edukasi',
          ),
          // 4. Tambahkan Icon Navigasi untuk Jurnal
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu), // Ikon buku/riwayat
            label: 'Jurnal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Agar ikon tidak bergeser jika > 3 item
      ),
    );
  }
}