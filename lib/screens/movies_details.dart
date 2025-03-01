import 'package:flutter/material.dart';

class MoviesDetailScreen extends StatefulWidget {
  static const routeName = '/movie_detail';
  const MoviesDetailScreen({super.key});

  @override
  State<MoviesDetailScreen> createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Detail')),
      body: const Center(child: Text('Movie Detail Screen')),
    );
  }
}
