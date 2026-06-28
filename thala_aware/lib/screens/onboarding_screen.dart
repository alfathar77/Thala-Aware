import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import ini

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller untuk input nama
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Untuk validasi form

  void _onIntroEnd(BuildContext context) async {
    // Validasi: Nama tidak boleh kosong
    if (_formKey.currentState!.validate()) {
      // Simpan nama ke memori HP
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text);
      await prefs.setBool('is_onboarding_done', true); // Tandai sudah selesai onboarding

      // Pindah ke Home
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      pages: [
        // Halaman 1 & 2 sama seperti sebelumnya...
        PageViewModel(
          title: "Selamat Datang",
          body: "Aplikasi untuk membantu Anda memahami risiko Thalassemia.",
          image: const Center(child: Icon(Icons.health_and_safety, size: 100.0, color: Colors.teal)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Cegah Thalassemia",
          body: "Pahami risiko Anda dan pasangan demi masa depan keluarga.",
          image: const Center(child: Icon(Icons.family_restroom, size: 100.0, color: Colors.teal)),
          decoration: pageDecoration,
        ),

        // --- HALAMAN 3: LOGIN / INPUT NAMA ---
        PageViewModel(
          title: "Satu Langkah Lagi",
          bodyWidget: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Masukkan nama Anda agar kami bisa mencatat riwayat skrining Anda dengan rapi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          image: const Center(child: Icon(Icons.login, size: 100.0, color: Colors.teal)),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      // Matikan tombol Skip agar user WAJIB isi nama
      showSkipButton: false, 
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Mulai', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}