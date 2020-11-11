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
        return Dismissible(
          key: UniqueKey(), //Key(filenames[index]),
          onDismissed: (DismissDirection d) => {},
          background: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(width: 2 * BelchCard.MARGIN),
                Icon(Icons.delete,
                    color: Colors.red, size: 2 * BelchCard.MARGIN),
                Expanded(child: Container()),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(child: Container()),
                Icon(Icons.delete,
                    color: Colors.red, size: 2 * BelchCard.MARGIN),
                Container(width: 2 * BelchCard.MARGIN),
              ],
            ),
          ),
          child: BelchCard(filenames[index]),
        );
      },
    );
  }
}
