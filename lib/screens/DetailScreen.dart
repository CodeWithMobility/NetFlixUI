// @dart=2.17

import 'package:flutter/material.dart';
import 'package:flutter_netflex_ui/models/MyModels.dart';
import 'package:flutter_netflex_ui/widget/CircularClipper.dart';
import 'package:flutter_netflex_ui/widget/HorizontalScrollWidget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isSaved = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildHero(movie),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              children: <Widget>[
                Text(
                  movie.title.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  movie.categories,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Icon(Icons.star, color: Color(0xFFFFB300), size: 28),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _MovieFact(label: 'Year', value: '${movie.year}'),
                    _MovieFact(
                        label: 'Country', value: movie.country.toUpperCase()),
                    _MovieFact(label: 'Length', value: '${movie.length} min'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  movie.description,
                  style: const TextStyle(color: Colors.black87, height: 1.5),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          HorizontalScrollWidget(
            images: movie.screenshots,
            title: 'Screenshots',
            imageHeight: 200,
            imageWidth: 250,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHero(Movie movie) {
    return SizedBox(
      height: 390,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(0, -30),
            child: Hero(
              tag: movie.imageUrl,
              child: ClipShadowPath(
                clipper: CircularClipper(),
                shadow: const Shadow(blurRadius: 20, color: Colors.black38),
                child: Image.asset(movie.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Image.asset(
                    'assets/images/netflix_logo.png',
                    height: 28,
                    semanticLabel: 'Netflix',
                  ),
                  IconButton(
                    tooltip:
                        _isSaved ? 'Remove from My List' : 'Add to My List',
                    onPressed: () {
                      setState(() => _isSaved = !_isSaved);
                      _showMessage(_isSaved
                          ? 'Added to My List'
                          : 'Removed from My List');
                    },
                    icon:
                        Icon(_isSaved ? Icons.favorite : Icons.favorite_border),
                    color: _isSaved ? Colors.red : Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                heroTag: 'play-${movie.imageUrl}',
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                tooltip: 'Play ${movie.title}',
                onPressed: () =>
                    _showMessage('Playback is not available in this demo.'),
                child: const Icon(Icons.play_arrow, size: 38),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 12,
            child: IconButton(
              tooltip: 'Share',
              onPressed: () =>
                  _showMessage('Sharing is not available in this demo.'),
              icon: const Icon(Icons.share),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieFact extends StatelessWidget {
  const _MovieFact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(label,
            style: const TextStyle(color: Colors.black54, fontSize: 14)),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
