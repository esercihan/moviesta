import 'package:flutter/material.dart'; // Temel Flutter kütüphanesi
import '../services/movie_service.dart'; // Film servisi
import 'movie_details_screen.dart'; // Film detay ekranı

class CategoryScreen extends StatelessWidget {
  final String categoryId; // Kategori ID'si
  final MovieService _movieService = MovieService(); // MovieService nesnesi

  CategoryScreen({super.key, required this.categoryId}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Ekranın oluşturulduğu metot
    return Scaffold(
      // Ekranın yapısını oluşturan widget
      appBar: AppBar(
        // Üst kısım
        title: Text(getCategoryName(categoryId)), // Kategori adı
      ),
      body: FutureBuilder(
        // Gelecek veriyi bekleyen widget
        future:
            _movieService.getTopRatedMovies(categoryId), // Veri çekme metodu
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          // Veri geldiğinde yapılacaklar
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veri beklenirken
            return const Center(
                child: CircularProgressIndicator()); // Dönen ilerleme çubuğu
          } else if (snapshot.hasError) {
            // Veri alınırken hata oluştuysa
            return Center(
                child: Text('Error: ${snapshot.error}')); // Hata mesajı
          } else {
            return ListView.builder(
              // Liste oluşturan widget
              itemCount: snapshot
                  .data!.length, // Veri sayısı kadar eleman oluşturulacak
              itemBuilder: (context, index) {
                // Eleman oluşturma metodu
                final movie = snapshot.data![index]; // Filmin verileri
                return Card(
                  // Kart oluşturan widget
                  color: Colors.transparent, // Kart rengi
                  elevation: 4, // Kartın yüksekliği
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10), // Kartın kenar boşlukları
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2 / 3 -
                        16, // 2/3'ü kadar genişlik
                    decoration: BoxDecoration(
                      // Kartın arka planı
                      gradient: LinearGradient(
                        // Kartın arka planı
                        begin: Alignment.centerLeft, // Başlangıç noktası
                        end: Alignment.centerRight, // Bitiş noktası
                        colors: [Colors.pink, Colors.lime.shade300], // Renkler
                      ),
                    ),
                    child: ListTile(
                      // Liste elemanı
                      trailing: Image.network(
                        // Sağ tarafta resim
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}', // Resim URL'si
                        width: 50, // Resim genişliği
                      ),
                      title: Text(
                        // Başlık
                        movie['title'], // Film adı
                        style: const TextStyle(
                            color: Colors.white), // Beyaz metin rengi
                      ),
                      subtitle: Text(
                        // Alt başlık
                        'Rating: ${movie['vote_average']}', // Oy ortalaması
                        style: const TextStyle(
                            color: Colors.white), // Beyaz metin rengi
                      ),
                      onTap: () {
                        // Tıklanınca yapılacaklar
                        Navigator.push(
                          // Yeni sayfaya geçiş
                          context, // Geçiş yapılacak ekran
                          MaterialPageRoute(
                            // Geçiş yapılacak ekran
                            builder: (context) => MovieDetailsScreen(
                              // Geçiş yapılacak ekran
                              movieId: movie['id'].toString(), // Film ID'si
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String getCategoryName(String categoryId) {
    // Kategori adını döndüren metot
    switch (categoryId) {
      // Kategori ID'sine göre kategori adı
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
