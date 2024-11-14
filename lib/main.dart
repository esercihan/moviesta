import 'package:flutter/material.dart'; // Temel Flutter kütüphanesi
import 'screens/splash_screen.dart';  // Splash ekranı

void main() { // Ana metot
  runApp(const MyApp());  // Uygulamayı çalıştır
}

class MyApp extends StatelessWidget { // Uygulama sınıfı
  const MyApp({super.key}); // Constructor

  @override // Ekranın oluşturulması
  Widget build(BuildContext context) {  // Ekranın oluşturulması
    return MaterialApp( // Uygulama yapısı
      debugShowCheckedModeBanner: false,  // Debug bandını kaldır
      title: 'Moviesta',  // Uygulama adı
      theme: ThemeData( // Tema
        fontFamily: 'Poppins',  // Yazı tipi
      ),
      home: const SplashScreen(), // Başlangıç ekranı
    );
  }
}
