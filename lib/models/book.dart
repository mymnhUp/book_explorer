class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String? thumbnail;
  final String? description;
  final String? publisher;
  final String? publishedDate;
  final List<String> categories;
  final double? rating;
  final int? pageCount;
  final String? previewLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.thumbnail,
    this.description,
    this.publisher,
    this.publishedDate,
    this.categories = const [],
    this.rating,
    this.pageCount,
    this.previewLink,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    String? coverUrl;

    if (json['cover_i'] != null) {
      coverUrl =
      'https://covers.openlibrary.org/b/id/${json['cover_i']}-M.jpg';
    }

    return Book(
      id: json['key']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled',
      authors: json['author_name'] != null
          ? List<String>.from(json['author_name'])
          : ['Unknown Author'],
      thumbnail: coverUrl,
      description: null,
      publisher: json['publisher'] != null &&
          (json['publisher'] as List).isNotEmpty
          ? json['publisher'][0].toString()
          : null,
      publishedDate: json['first_publish_year']?.toString(),
      categories: json['subject'] != null
          ? List<String>.from(json['subject']).take(3).toList()
          : [],
      rating: null,
      pageCount: null,
      previewLink: json['key'] != null
          ? 'https://openlibrary.org${json['key']}'
          : null,
    );
  }
}