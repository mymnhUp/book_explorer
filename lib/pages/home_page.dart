import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import '../widgets/book_card.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController =
  TextEditingController();

  List<Book> _books = [];
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> categories = [
    'All',
    'Fiction',
    'Fantasy',
    'Romance',
    'Science',
    'History',
    'Education',
  ];

  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadBooks('best books');
  }

  Future<void> _loadBooks(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final books = await _apiService.searchBooks(query);

      if (!mounted) return;

      setState(() {
        _books = books;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage =
        'Tidak dapat mengambil data buku.';
      });
    }
  }

  void _searchBooks() {
    final query = _searchController.text.trim();

    if (query.isNotEmpty) {
      _loadBooks(query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 23,
              ),
            ),

            const SizedBox(width: 12),

            const Text(
              'Book Explorer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A202C),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF475467),
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _loadBooks(
            _searchController.text.trim().isEmpty
                ? 'popular books'
                : _searchController.text.trim(),
          ),

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              20,
              5,
              20,
              30,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                const Text(
                  'Discover your next',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1A202C),
                  ),
                ),

                const Text(
                  'favorite book.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2563EB),
                  ),
                ),

                const SizedBox(height: 22),

                // SEARCH BAR
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: TextField(
                    controller: _searchController,

                    textInputAction:
                    TextInputAction.search,

                    onSubmitted: (_) => _searchBooks(),

                    decoration: InputDecoration(
                      hintText: 'Search books, authors...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF98A2B3),
                        fontSize: 14,
                      ),

                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF667085),
                      ),

                      suffixIcon: IconButton(
                        onPressed: _searchBooks,
                        icon: Container(
                          padding:
                          const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFF2563EB),
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      border: InputBorder.none,

                      contentPadding:
                      const EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // RECOMMENDED
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Recommended Books',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A202C),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        _loadBooks('best books');
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                if (_isLoading)
                  const SizedBox(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  )
                else if (_errorMessage != null)
                  _buildError()
                else if (_books.isEmpty)
                    _buildEmpty()
                  else
                    SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];

                          return BookCard(
                            book: book,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailPage(
                                        book: book,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                const SizedBox(height: 25),

                // CATEGORIES
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 42,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,

                    itemBuilder: (context, index) {
                      final category =
                      categories[index];

                      final isSelected =
                          selectedCategory ==
                              category;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory =
                                category;
                          });

                          if (category == 'All') {
                            _loadBooks(
                              'popular books',
                            );
                          } else {
                            _loadBooks(
                              category,
                            );
                          }
                        },

                        child: Container(
                          margin:
                          const EdgeInsets.only(
                            right: 9,
                          ),

                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(
                              0xFF2563EB,
                            )
                                : Colors.white,

                            borderRadius:
                            BorderRadius.circular(
                              22,
                            ),

                            border: Border.all(
                              color: isSelected
                                  ? const Color(
                                0xFF2563EB,
                              )
                                  : const Color(
                                0xFFE2E8F0,
                              ),
                            ),
                          ),

                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                              FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(
                                0xFF667085,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // BOOK LIST
                const Text(
                  'Explore Books',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                  ),
                ),

                const SizedBox(height: 15),

                if (!_isLoading &&
                    _books.isNotEmpty)
                  ..._books.take(6).map(
                        (book) => _buildListBook(book),
                  ),
              ],
            ),
          ),
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        onTap: (index) {},

        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.white,

        selectedItemColor:
        const Color(0xFF2563EB),

        unselectedItemColor:
        const Color(0xFF98A2B3),

        selectedLabelStyle:
        const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),

        unselectedLabelStyle:
        const TextStyle(
          fontSize: 11,
        ),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildListBook(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(book: book),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            Container(
              width: 65,
              height: 85,

              decoration: BoxDecoration(
                color: const Color(0xFFE9EEF8),
                borderRadius:
                BorderRadius.circular(10),
              ),

              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),

                child: book.thumbnail != null
                    ? Image.network(
                  book.thumbnail!
                      .replaceFirst(
                    'http://',
                    'https://',
                  ),
                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Icon(
                      Icons.book,
                      color: Color(
                        0xFF718096,
                      ),
                    );
                  },
                )
                    : const Icon(
                  Icons.book,
                  color: Color(0xFF718096),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    book.title,

                    maxLines: 2,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700,
                      color: Color(
                        0xFF1A202C,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    book.authors.isNotEmpty
                        ? book.authors.first
                        : 'Unknown Author',

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(
                        0xFF667085,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  if (book.categories.isNotEmpty)
                    Text(
                      book.categories.first,

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(
                          0xFF2563EB,
                        ),
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF98A2B3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 45,
            color: Color(0xFF98A2B3),
          ),

          const SizedBox(height: 10),

          const Text(
            'Gagal memuat buku',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Periksa koneksi internet kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              _loadBooks('popular books');
            },

            style: ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xFF2563EB),
              foregroundColor: Colors.white,
            ),

            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Text(
          'Tidak ada buku ditemukan.',
          style: TextStyle(
            color: Color(0xFF667085),
          ),
        ),
      ),
    );
  }
}