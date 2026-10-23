import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              width: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFE9EEF8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: book.thumbnail != null
                    ? Image.network(
                  book.thumbnail!.replaceFirst(
                    'http://',
                    'https://',
                  ),
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.book,
                        size: 50,
                        color: Color(0xFF718096),
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Icon(
                    Icons.book,
                    size: 50,
                    color: Color(0xFF718096),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              book.authors.isNotEmpty
                  ? book.authors.first
                  : 'Unknown Author',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }
}