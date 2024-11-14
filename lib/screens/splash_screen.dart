import 'package:flutter/material.dart'; // Temel Flutter kütüphanesi
import 'dart:async';  // Zamanlayıcı kütüphanesi
import 'home_screen.dart';  // Ana ekran

class SplashScreen extends StatelessWidget {  // Başlangıç ekranı
  const SplashScreen({super.key});  // Constructor

  @override
  Widget build(BuildContext context) {
    // Future.delayed ile 3 saniye bekleyip sonra HomeScreen'e geçiş yapılıyor
    Future.delayed(const Duration(seconds: 4), () { // 4 saniye bekletme
      Navigator.of(context).pushReplacement(  // Ekranı değiştirme
        MaterialPageRoute(builder: (_) => HomeScreen()),  // Yeni ekran
      );
    });

    return Scaffold(
      backgroundColor: Colors.black, // Pembe arka plan rengi
      body: Center( // Ortala
        child: Column(  // Sütun
          mainAxisAlignment: MainAxisAlignment.center,  // Ortala
          children: [ // İçerik
            Image.asset(  // Resim
              'assets/images/logo.png',  // Logo resmi
              width: 400, // Resim genişliği
              height: 400, // Resim yüksekliği
            ),
            const SizedBox(height: 20), // Boşluk
            const CircularProgressIndicator(), // Dönen ilerleme çubuğu
          ],
        ),
      ),
    );
  }
}
