import 'dart:typed_data';

import 'package:belchometer/useless.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'useless.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';

/// 6 Sep 20
///
/// A card widget representing a belch sound file.
///
/// Allows swiping to like or discard belches, as well as a play button to hear
/// it again.
class BelchCard extends StatelessWidget {
  String title;
  FlutterSoundPlayer player = FlutterSoundPlayer();

  BelchCard({this.title});

  void _playAudioFile() async {
    try {
      Uint8List buffer = (await rootBundle.load('assets/belchsample.wav'))
          .buffer
          .asUint8List();
      player.startPlayer(fromDataBuffer: buffer);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Useless useless = Useless(context);
    player.openAudioSession();

    return InkWell(
      onTap: () => Navigator.of(context).push(new BelchPageRoute(this.title)),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: _playAudioFile,
          ),
          Hero(
            tag: 'title-${this.title}',
            child: Text("${this.title}"),
          ),
          Expanded(
            child: Center(
              child: Hero(
                tag: 'playhead-${this.title}',
                child: Text('====playhead===='),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
            ),
            onPressed: () => useless.uselessFunction('favorite this belch'),
          ),
        ],
      ),
    );
  }

  void dispose() {
    player.closeAudioSession();
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
            Hero(
              tag: 'title-${this.title}',
              child: Text('this is the main belch page'),
            ),
            Expanded(
              child: Center(
                child: Hero(
                  tag: 'playhead-${this.title}',
                  child: Text('playhead here'),
                ),
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
