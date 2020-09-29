import 'package:flutter/material.dart';
import 'belch_card.dart';
import 'dart:math';

class BelchList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BelchListState();
}

class BelchListState extends State {
  final filenames = [
    'assets/babybelch.wav',
    'assets/anotherbelch.wav',
    'assets/belchsample.wav',
    'assets/belch4.wav'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filenames.length,
      itemBuilder: (context, index) {
        bool swipingLeft = false;
        return BelchCard(filenames[index]);
      },
    );
  }
}
