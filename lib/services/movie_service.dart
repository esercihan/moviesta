import 'dart:convert'; // JSON dönüştürme kütüphanesi
import 'package:http/http.dart' as http; // HTTP kütüphanesi
import 'package:moviesta/api_key.dart'; // API anahtarları

class MovieService {
  // Film servisi
  Future<List<Map<String, dynamic>>> getTopRatedMovies(String category) async {
    // En iyi filmleri getiren metot
    final response = await http.get(Uri.parse(// API'dan veri çekme
        'https://api.themoviedb.org/3/discover/movie?api_key=$tmdbApiKey&sort_by=vote_count.desc&with_genres=$category')); // API URL'si

    if (response.statusCode == 200) {
      // Veri çekme başarılıysa
      final Map<String, dynamic> data =
          jsonDecode(response.body); // JSON verisini dönüştürme
      final List<dynamic> results = data['results']; // Sonuçlar
      List<Map<String, dynamic>> movies = // Filmler
          results.cast<Map<String, dynamic>>().toList();

      // Ratinge göre sırala
      movies.sort((a, b) {
        // Sıralama
        return b['vote_average']
            .compareTo(a['vote_average']); // Oy ortalamasına göre sırala
      });

      return movies; // Filmleri dön
    } else {
      // Veri çekme başarısızsa
      throw Exception('Failed to load movies'); // Hata mesajı
    }
  }
}
