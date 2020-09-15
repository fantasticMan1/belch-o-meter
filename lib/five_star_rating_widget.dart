import 'package:flutter/material.dart';

class FiveStarRating extends StatelessWidget {
  int _rating;

  FiveStarRating(int rating) {
    this._rating = rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_rating > 0 ? Icons.star : Icons.star_outline),
        Icon(_rating > 1 ? Icons.star : Icons.star_outline),
        Icon(_rating > 2 ? Icons.star : Icons.star_outline),
        Icon(_rating > 3 ? Icons.star : Icons.star_outline),
        Icon(_rating > 4 ? Icons.star : Icons.star_outline),
      ],
    );
  }
}
