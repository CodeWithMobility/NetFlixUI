// @dart=2.17

class ItemModel {
  const ItemModel({required this.title, required this.bgImage});

  final String title;
  final String bgImage;
}

class Movie {
  const Movie({
    required this.imageUrl,
    required this.title,
    required this.categories,
    required this.year,
    required this.country,
    required this.length,
    required this.description,
    required this.screenshots,
  });

  final String imageUrl;
  final String title;
  final String categories;
  final int year;
  final String country;
  final int length;
  final String description;
  final List<String> screenshots;
}

const List<ItemModel> items = <ItemModel>[
  ItemModel(title: 'Discover', bgImage: 'assets/images/a.jpg'),
  ItemModel(title: 'Categories', bgImage: 'assets/images/b.jpg'),
  ItemModel(title: 'Specials', bgImage: 'assets/images/c.jpg'),
  ItemModel(title: 'New', bgImage: 'assets/images/a.jpg'),
];

const List<Movie> movies = <Movie>[
  Movie(
    imageUrl: 'assets/images/spiderman.jpg',
    title: 'Spider-Man: Far From Home',
    categories: 'Fantasy, Sci-fi',
    year: 2018,
    country: 'USA',
    length: 129,
    description:
        'Our friendly neighborhood Super Hero decides to join his best friends Ned, MJ, and the rest of the gang on a European vacation. However, Peter\'s plan to leave super heroics behind for a few weeks is quickly scrapped when he agrees to help Nick Fury uncover the mystery of several elemental creature attacks.',
    screenshots: <String>[
      'assets/images/a.jpg',
      'assets/images/b.jpg',
      'assets/images/c.jpg',
    ],
  ),
  Movie(
    imageUrl: 'assets/images/terminator.jpg',
    title: 'The Terminator 5',
    categories: 'Action, Sci-fi',
    year: 2018,
    country: 'USA',
    length: 100,
    description:
        'A new threat puts the future in danger. One unlikely team must face impossible odds, make difficult choices, and fight to protect the people they love.',
    screenshots: <String>[
      'assets/images/a.jpg',
      'assets/images/b.jpg',
      'assets/images/c.jpg',
    ],
  ),
  Movie(
    imageUrl: 'assets/images/damnation.jpg',
    title: 'Damnation',
    categories: 'Adventure, Drama',
    year: 2018,
    country: 'USA',
    length: 100,
    description:
        'A small town is caught between old loyalties and a changing world. As tensions rise, its residents must decide what they are willing to risk for a better future.',
    screenshots: <String>[
      'assets/images/a.jpg',
      'assets/images/b.jpg',
      'assets/images/c.jpg',
    ],
  ),
];

const List<String> myList = <String>[
  'assets/images/l1.jpg',
  'assets/images/l2.jpg',
  'assets/images/l3.jpg',
  'assets/images/l4.jpg',
];

const List<String> specials = <String>[
  'assets/images/s1.jpg',
  'assets/images/s2.jpg',
  'assets/images/s3.jpg',
  'assets/images/s4.jpg',
  'assets/images/s5.jpg',
];
