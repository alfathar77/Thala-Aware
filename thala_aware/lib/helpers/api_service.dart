import 'dart:convert';
import 'package:flutter/foundation.dart'; // Untuk kIsWeb
import 'package:http/http.dart' as http;
import 'package:thala_aware/models/screening_log.dart';

class ApiService {
  // Logika IP Address (Localhost vs Android Emulator)
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost/thala_api"; 
    } else {
      // Gunakan 10.0.2.2 untuk Emulator Android bawaan
      // Gunakan IP Laptop (misal 192.168.1.x) jika debug pakai HP fisik
      return "http://10.0.2.2/thala_api"; 
    }
  }

  // 1. AMBIL DATA (Read)
  Future<List<ScreeningLog>> getLogs() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/read.php"));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => ScreeningLog.fromMap(data)).toList();
      } else {
        throw Exception('Gagal mengambil data.');
      }
    } catch (e) {
      print("Error API: $e");
      return [];
    }
  }

  // 2. TAMBAH DATA (Create)
  Future<bool> insertLog(ScreeningLog log) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/create.php"),
        body: {
          'username': log.username,
          'date': log.date,
          'location': log.location,
          'result': log.result,
          'notes': log.notes,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error Insert: $e");
      return false;
    }
  }

  // 3. HAPUS DATA (Delete)
  Future<bool> deleteLog(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/delete.php"),
        body: {'id': id.toString()},
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error Delete: $e");
      return false;
    }
  }

  // 4. SIMPAN RIWAYAT KALKULATOR (Baru)
  Future<bool> saveCalculation({
    required String username,
    required String userStatus,
    required String partnerStatus,
    required String riskResult,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/save_calc.php"),
        body: {
          'username': username,
          'date': DateTime.now().toString().substring(0, 10),
          'user_status': userStatus,
          'partner_status': partnerStatus,
          'risk_result': riskResult,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error Save Calc: $e");
      return false;
    }
  }
}