import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const String baseUrl =
      'https://openlibrary.org/search.json';

  Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse(
      '$baseUrl?q=${Uri.encodeQueryComponent(query)}'
          '&limit=20'
          '&fields=key,title,author_name,cover_i,'
          'first_publish_year,publisher,subject',
    );

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'BookExplorer/1.0',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
      jsonDecode(response.body);

      final List<dynamic> docs = data['docs'] ?? [];

      return docs
          .map(
            (item) => Book.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList();
    } else {
      throw Exception(
        'Gagal mengambil data buku '
            '(Status: ${response.statusCode})',
      );
    }
  }
}