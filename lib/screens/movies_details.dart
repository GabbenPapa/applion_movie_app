import 'package:applion_movie_app/models/movies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoviesDetailScreen extends StatefulWidget {
  static const routeName = '/movie_detail';
  final Movie movie;
  const MoviesDetailScreen({required this.movie, super.key});

  @override
  State<MoviesDetailScreen> createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends State<MoviesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.movie.id,
                          key: ValueKey(widget.movie.id),
                          child: Image.network(
                            widget.movie.fullPosterUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 100);
                            },
                          ),
                        ),

                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.movie.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.original_title}: ${widget.movie.originalTitle}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.release_date}: ${widget.movie.releaseDate.split("-")[0]}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.original_language}: ${widget.movie.originalLanguage.toUpperCase()}',
                                style: TextStyle(fontSize: 16),
                              ),

                              Text(
                                '${AppLocalizations.of(context)!.votes}: ${widget.movie.voteCount}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.popularity}: ${widget.movie.popularity.toStringAsFixed(1)}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.movie.overview,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
