import 'package:belchometer/useless.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'useless.dart';
import 'audio_manager.dart';
import 'belch_analysis.dart';
import 'five_star_rating_widget.dart';
import 'theme.dart';

/// 6 Sep 20
///
/// A card widget representing a belch sound file.
///
/// Allows swiping to like or discard belches, as well as a play button to hear
/// it again.
class BelchCard extends StatefulWidget {
  static const double HEIGHT = 100.0;
  static const double SPACING = 10.0;
  static const double MARGIN = 15.0;

  String _fname;
  int rating;

  BelchAnalysis belchAnalysis = BelchAnalysis();

  BelchCard(String fname) {
    this._fname = fname;
    this.rating = belchAnalysis.analyzeBelch([]);
  }

  @override
  State<StatefulWidget> createState() => BelchCardState(_fname, rating);
}

class BelchCardState extends State {
  String _fname;
  String _title;
  int rating;
  final Icon _filledHeart = Icon(Icons.favorite);
  final Icon _outlinedHeart = Icon(Icons.favorite_outline);
  Icon _favoriteIcon;
  AudioManager audioManager = AudioManager();

  @override
  void initState() {
    _favoriteIcon = _outlinedHeart;
    super.initState();
  }

  void _toggleFavorited() {
    Icon newIcon =
        _favoriteIcon == _filledHeart ? _outlinedHeart : _filledHeart;
    setState(() {
      _favoriteIcon = newIcon;
    });
  }

  BelchCardState(String fname, int rating) {
    this.rating = rating;
    this._fname = fname;
    // Get just the filename. Chop off path and extension.
    this._title = fname.substring(
      max(fname.lastIndexOf('/') + 1, 0),
      max(fname.lastIndexOf('.'), 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Useless useless = Useless(context);

    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(BelchCard.MARGIN),
      child: Container(
        decoration: BoxDecoration(
          color: ALMOST_BLACK,
          borderRadius: BorderRadius.all(Radius.circular(BelchCard.MARGIN)),
        ),
        height: BelchCard.HEIGHT,
        child: InkWell(
          child: Row(
            children: [
              Container(width: BelchCard.SPACING),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () => audioManager.playSample(_fname),
              ),
              Container(width: BelchCard.SPACING),
              Text(_title, style: TextStyle(fontSize: 18)),
              Expanded(child: Container()),
              FiveStarRating(rating),
              Container(width: BelchCard.SPACING),
              IconButton(
                icon: _favoriteIcon,
                onPressed: _toggleFavorited,
              ),
              Container(width: BelchCard.SPACING),
            ],
          ),
        ),
      ),
    );
  }
}
