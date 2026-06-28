import 'package:flutter/material.dart';
import 'package:thala_aware/screens/home_screen.dart';
import 'package:thala_aware/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thala-Aware',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Ganti warna primer sesuai keinginan
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 1,
        ),
      ),
      // Kita mulai dari OnboardingScreen
      // OnboardingScreen akan mengarahkan ke HomeScreen setelah selesai
      home: OnboardingScreen(), 
      routes: {
        '/home': (context) => HomeScreen(),
        // Rute lain bisa ditambahkan di sini
      },
      debugShowCheckedModeBanner: false,
    );
  }
}