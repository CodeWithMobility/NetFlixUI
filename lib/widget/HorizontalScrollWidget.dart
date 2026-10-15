// @dart=2.17

import 'package:flutter/material.dart';

class HorizontalScrollWidget extends StatelessWidget {
  const HorizontalScrollWidget({
    Key? key,
    required this.images,
    required this.title,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  final List<String> images;
  final String title;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: imageHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => SizedBox(
              width: imageWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  semanticLabel: '$title ${index + 1}',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
