import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BookExplorerApp());
}

class BookExplorerApp extends StatelessWidget {
  const BookExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Explorer',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),

        scaffoldBackgroundColor:
        const Color(0xFFF7F9FC),
      ),

      home: const HomePage(),
    );
  }
}