import 'package:flutter/material.dart';
import '../models/book.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = book.thumbnail?.replaceFirst(
      'http://',
      'https://',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1A202C),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Details',
          style: TextStyle(
            color: Color(0xFF1A202C),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          24,
          10,
          24,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 300,
                width: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFE9EEF8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: imageUrl != null
                      ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return const Icon(
                        Icons.book,
                        size: 70,
                        color: Color(0xFF718096),
                      );
                    },
                  )
                      : const Icon(
                    Icons.book,
                    size: 70,
                    color: Color(0xFF718096),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              book.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A202C),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              book.authors.join(', '),
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF667085),
              ),
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (book.rating != null)
                  _InfoChip(
                    icon: Icons.star,
                    text: book.rating!.toStringAsFixed(1),
                  ),

                if (book.publishedDate != null)
                  _InfoChip(
                    icon: Icons.calendar_today_outlined,
                    text: book.publishedDate!,
                  ),

                if (book.pageCount != null)
                  _InfoChip(
                    icon: Icons.menu_book_outlined,
                    text: '${book.pageCount} pages',
                  ),
              ],
            ),

            const SizedBox(height: 28),

            if (book.categories.isNotEmpty) ...[
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: book.categories
                    .take(3)
                    .map(
                      (category) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0FF),
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),

              const SizedBox(height: 28),
            ],

            const Text(
              'About this book',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book.description ??
                  'No description available for this book.',
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF667085),
              ),
            ),

            const SizedBox(height: 25),

            if (book.publisher != null)
              Row(
                children: [
                  const Icon(
                    Icons.business_outlined,
                    size: 20,
                    color: Color(0xFF667085),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      book.publisher!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF2563EB),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475467),
            ),
          ),
        ],
      ),
    );
  }
}