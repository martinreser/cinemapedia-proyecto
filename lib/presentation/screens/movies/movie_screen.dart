import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  static const name = 'movie-screen';

  final String movieID;

  const MovieScreen({super.key, required this.movieID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie ID: $movieID'),
      ),
    );
  }
}
