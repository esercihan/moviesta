import 'package:flutter/material.dart'; // Temel Flutter kütüphanesi
import 'dart:convert';  // JSON dönüştürme kütüphanesi
import 'package:http/http.dart' as http;  // HTTP kütüphanesi
import 'package:moviesta/api_key.dart'; // API anahtarları

class MovieDetailsScreen extends StatelessWidget {  // Film detayları ekranı
  final String movieId; // Film ID'si

  const MovieDetailsScreen({super.key, required this.movieId}); // Constructor

  @override
  Widget build(BuildContext context) {  // Ekranın oluşturulması
    return Scaffold(  // Ekran yapısı
      appBar: AppBar( // Üst kısım
        title: const Text('Film Detayı'), // Başlık
      ),
      body: FutureBuilder(  // Gelecek veriyi bekleyen widget
        future: _fetchMovieDetails(movieId),  // Veri çekme metodu
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {  // Veri geldiğinde yapılacaklar
          if (snapshot.connectionState == ConnectionState.waiting) {  // Veri beklenirken
            return const Center(child: CircularProgressIndicator());  // Dönen ilerleme çubuğu
          } else if (snapshot.hasError) { // Veri alınırken hata oluştuysa
            return Center(child: Text('Hata: ${snapshot.error}'));  // Hata mesajı
          } else {  // Veri alındıysa
            final movie = snapshot.data!; // Film verileri
            return SingleChildScrollView( // Kaydırılabilir ekran
              padding: const EdgeInsets.all(16.0),  // Kenar boşlukları
              child: Column(  // Sütun
                crossAxisAlignment: CrossAxisAlignment.start, // Sola yaslanma
                children: [ // İçerik
                  SizedBox( // Resim
                    height: 300,  // Yükseklik
                    child: Image.network( // Resim
                      'https://image.tmdb.org/t/p/w500${movie['poster_path']}', // Resim URL'si
                      fit: BoxFit.cover,  // Resmi kapla
                    ),
                  ),
                  const SizedBox(height: 16.0), // Boşluk
                  Text( // Metin
                    'Yapım Yılı: ${movie['release_date'].substring(0, 4)}', // Yapım yılı
                    style: const TextStyle(fontWeight: FontWeight.bold),  // Kalın metin
                  ),
                  const SizedBox(height: 8.0),  // Boşluk
                  Text( // Metin
                    'Yönetmen: ${movie['director']}', // Yönetmen
                    style: const TextStyle(fontWeight: FontWeight.bold),  // Kalın metin
                  ),
                  const SizedBox(height: 16.0), // Boşluk
                  const Text( // Metin
                    'Konu:',
                    style: TextStyle(fontWeight: FontWeight.bold),  // Kalın metin
                  ),
                  const SizedBox(height: 8.0),  // Boşluk
                  Text(
                    movie['overview'],  // Film özeti
                    style: const TextStyle(fontSize: 16.0),  // Metin boyutu
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchMovieDetails(String movieId) async { // Film detaylarını çeken metot
    final url = Uri.parse(  // URL oluşturma
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$tmdbApiKey&append_to_response=credits');  // API URL'si
    final response = await http.get(url); // API'dan veri çekme

    if (response.statusCode == 200) { // Veri çekme başarılıysa
      final Map<String, dynamic> responseData =  // JSON verisini dönüştürme
          json.decode(utf8.decode(response.bodyBytes)); // JSON verisini dönüştürme (UTF-8)

      final translatedOverview =  // Özeti çevirme
          await _translateOverview(responseData['overview']); // Özeti çevirme

      final director = responseData['credits']['crew'].firstWhere(  // Yönetmeni bulma
          (crew) => crew['job'] == 'Director',  // Yönetmen
          orElse: () => {'name': 'Bilinmiyor'})['name'];  // Yönetmen

      return {  // Veri dönüşü
        'poster_path': responseData['poster_path'], // Resim yolu
        'overview': translatedOverview, // Çevrilen özet
        'release_date': responseData['release_date'], // Yayın tarihi
        'director': director, // Yönetmen
      };
    } else {  // Veri çekme başarısızsa
      throw Exception('Film detayları yüklenirken hata oluştu');  // Hata mesajı
    }
  }

  Future<String> _translateOverview(String overview) async {  // Özeti çeviren metot
    final deeplUrl = Uri.parse('https://api-free.deepl.com/v2/translate');  // Deepl API URL'si
    final response = await http.post( // API'ya POST isteği
      deeplUrl, // Deepl URL'si
      body: { // Gövde
        'auth_key': deeplApiKey,  // Deepl API anahtarı
        'text': overview, // Özet metni
        'source_lang': 'EN',  // Kaynak dil
        'target_lang': 'TR',  // Hedef dil
      },
    );

    if (response.statusCode == 200) { // Çeviri başarılıysa
      final Map<String, dynamic> responseData = // JSON verisini dönüştürme
          json.decode(utf8.decode(response.bodyBytes)); // JSON verisini dönüştürme
      return responseData['translations'][0]['text']; // Çevrilen metni dönüş
    } else {  // Çeviri başarısızsa
      throw Exception('Özet çevirisi başarısız oldu');  // Hata mesajı
    }
  }
}
