// @dart=2.17

import 'package:flutter/material.dart';
import 'package:flutter_netflex_ui/models/MyModels.dart';
import 'package:flutter_netflex_ui/screens/DetailScreen.dart';
import 'package:flutter_netflex_ui/widget/HorizontalScrollWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.84);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openMovie(Movie movie) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(builder: (_) => DetailScreen(movie: movie)),
    );
  }

  Future<void> _openSearch() async {
    final movie = await showSearch<Movie?>(
      context: context,
      delegate: _MovieSearchDelegate(),
    );
    if (movie != null && mounted) _openMovie(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Menu',
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Choose a title to start browsing.')),
          ),
          icon: const Icon(Icons.menu),
        ),
        title: Image.asset(
          'assets/images/netflix_logo.png',
          height: 30,
          semanticLabel: 'Netflix',
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search titles',
            onPressed: _openSearch,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildCarousel(),
          _buildCategories(),
          const SizedBox(height: 12),
          const HorizontalScrollWidget(
            images: myList,
            title: 'My List',
            imageHeight: 250,
            imageWidth: 150,
          ),
          const SizedBox(height: 12),
          const HorizontalScrollWidget(
            images: specials,
            title: 'Popular on Netflix',
            imageHeight: 250,
            imageWidth: 150,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Semantics(
            label: item.title,
            image: true,
            child: Container(
              width: 160,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(item.bgImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.55),
                    BlendMode.darken,
                  ),
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x339E1F28),
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                item.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              var distance = 0.0;
              if (_pageController.hasClients &&
                  _pageController.position.hasContentDimensions) {
                distance = (_pageController.page! - index).abs();
              }
              final scale = (1 - distance * 0.2).clamp(0.8, 1.0).toDouble();
              return Center(
                child: Transform.scale(scale: scale, child: child),
              );
            },
            child: _buildMovieCard(movie),
          );
        },
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Semantics(
      button: true,
      label: 'View ${movie.title}',
      child: GestureDetector(
        onTap: () => _openMovie(movie),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Hero(
                  tag: movie.imageUrl,
                  child: Image.asset(movie.imageUrl, fit: BoxFit.cover),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, Colors.black87],
                      stops: <double>[0.45, 1],
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 16,
                  child: Text(
                    movie.title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieSearchDelegate extends SearchDelegate<Movie?> {
  @override
  String get searchFieldLabel => 'Search movies';

  List<Movie> get _matches => movies
      .where((movie) =>
          movie.title.toLowerCase().contains(query.trim().toLowerCase()))
      .toList(growable: false);

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        if (query.isNotEmpty)
          IconButton(
            tooltip: 'Clear search',
            onPressed: () => query = '',
            icon: const Icon(Icons.clear),
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        tooltip: 'Close search',
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => _buildMatches(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildMatches(context);

  Widget _buildMatches(BuildContext context) {
    final matches = _matches;
    if (matches.isEmpty) {
      return const Center(child: Text('No matching titles'));
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final movie = matches[index];
        return ListTile(
          leading: const Icon(Icons.movie_outlined),
          title: Text(movie.title),
          subtitle: Text('${movie.year} · ${movie.categories}'),
          onTap: () => close(context, movie),
        );
      },
    );
  }
}
