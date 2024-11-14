import 'package:flutter/material.dart'; // Temel Flutter kütüphanesi
import 'category_screen.dart';  // Kategori ekranı

class HomeScreen extends StatelessWidget {  // Ana ekran
  HomeScreen({super.key});  // Constructor
  final List<String> categories = [ // Kategoriler
    '28', // Aksiyon
    '12', // Macera
    '16', // Animasyon
    '35', // Komedi
    '80', // Suç
    '99', // Belgesel
    '18', // Drama
    '10751', // Aile
    '14', // Fantastik
    '36', // Tarih
    '27', // Korku
    '10402', // Müzik
    '9648', // Gizem
    '10749', // Romantik
    '878', // Bilim Kurgu
    '53', // Gerilim
    '10770', // TV Filmi
    '10752', // Savaş
    '37', // Western
  ];

  @override
  Widget build(BuildContext context) {  // Ekranın oluşturulması
    return Scaffold(  // Ekran yapısı
      appBar: AppBar(
        title: Row( // Başlık
          children: [ // İçerik
            Image.asset(  // Logo
              'assets/images/cat.png',  // Logo resmi
              alignment: Alignment.center,  // Ortala
              width: 50,  // Genişlik
              height: 50, // Yükseklik
            ),
            Image.asset(  // Logo
              'assets/images/moviesta.png', // Logo resmi
              width: 150, // Genişlik
              height: 150,  // Yükseklik
              alignment: Alignment.center,  // Ortala
            )
          ],
        ), // Logo yazısı
      ),
      backgroundColor: Colors.pink, // Pembe arka plan
      body: ListView.builder( // Liste yapısı
        itemCount: categories.length, // Kategori sayısı
        itemBuilder: (context, index) { // Liste elemanları
          return ListTile(  // Liste elemanı
            title: Row( // Satır
              mainAxisAlignment:       
                  MainAxisAlignment.spaceBetween, // Sağa yaslanma
              children: [ // İçerik
                Text( // Metin
                  getCategoryName(categories[index]), // Kategori adı
                  style:
                      const TextStyle(color: Colors.white), // Beyaz metin rengi
                ),
                const Icon( // İkon
                  Icons.arrow_forward,  // Sağa doğru ok ikonu
                  color: Colors.white, // Beyaz ikon rengi
                ), 
              ],
            ),
            onTap: () { // Tıklanınca yapılacaklar
              Navigator.push( // Yeni sayfaya geçiş
                context,  // Geçiş yapılacak ekran
                MaterialPageRoute(  // Geçiş yapılacak ekran
                  builder: (context) => // Geçiş yapılacak ekran
                      CategoryScreen(categoryId: categories[index]),  // Kategori ekranı
                ),
              );
            },
          );
        },
      ),
    );
  }

  String getCategoryName(String categoryId) { //category ID ye göre kategori adını döndüren fonksiyon
    switch (categoryId) { // Kategori ID'sine göre kategori adı
      case '28':
        return 'Aksiyon';
      case '12':
        return 'Macera';
      case '16':
        return 'Animasyon';
      case '35':
        return 'Komedi';
      case '80':
        return 'Suç';
      case '99':
        return 'Belgesel';
      case '18':
        return 'Drama';
      case '10751':
        return 'Aile';
      case '14':
        return 'Fantastik';
      case '36':
        return 'Tarih';
      case '27':
        return 'Korku';
      case '10402':
        return 'Müzik';
      case '9648':
        return 'Gizem';
      case '10749':
        return 'Romantik';
      case '878':
        return 'Bilim Kurgu';
      case '53':
        return 'Gerilim';
      case '10770':
        return 'TV Filmi';
      case '10752':
        return 'Savaş';
      case '37':
        return 'Western';
      default:
        return 'Bilinmeyen';
    }
  }
}
