import 'package:belchometer/useless.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'useless.dart';
import 'audio_manager.dart';
import 'belch_analysis.dart';
import 'five_star_rating_widget.dart';

/// 6 Sep 20
///
/// A card widget representing a belch sound file.
///
/// Allows swiping to like or discard belches, as well as a play button to hear
/// it again.
class BelchCard extends StatelessWidget {
  static const double HEIGHT = 100.0;
  static const double SPACING = 10.0;

  String _fname;
  String _title;

  AudioManager audioManager = AudioManager();
  BelchAnalysis belchAnalysis = BelchAnalysis();

  BelchCard(String fname) {
    // Get just the filename. Chop off path and extension.
    this._fname = fname;
    this._title = fname.substring(
      max(fname.lastIndexOf('/') + 1, 0),
      max(fname.lastIndexOf('.'), 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Useless useless = Useless(context);

    int rating = belchAnalysis.analyzeBelch([]);

    return InkWell(
      onTap: () => Navigator.of(context).push(new BelchPageRoute(this._title)),
      child: Container(
        height: HEIGHT,
        child: Row(
          children: [
            Container(width: SPACING),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => audioManager.playSample(this._fname),
            ),
            Container(width: SPACING),
            Text("${this._title}", style: TextStyle(fontSize: 18)),
            Expanded(child: Container()),
            FiveStarRating(rating),
            Container(width: SPACING),
            IconButton(
              icon: Icon(
                Icons.favorite_border,
              ),
              onPressed: () => useless.uselessFunction('favorite this belch'),
            ),
            Container(width: SPACING),
          ],
        ),
      ),
    );
  }
}

class BelchPage extends StatelessWidget {
  String title;

  BelchPage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Belch Page'),
      ),
      body: Container(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => print('reimplement me with a snackbar'),
            ),
            Text('this is the main belch page'),
            Expanded(
              child: Center(
                child: Text('playhead here'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite_outline),
              onPressed: () => print('reimplement me with a snackbar'),
            )
          ],
        ),
      ),
    );
  }
}

class BelchPageRoute extends MaterialPageRoute {
  BelchPageRoute(String title)
      : super(builder: (context) => new BelchPage(title: title));

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
