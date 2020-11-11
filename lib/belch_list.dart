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
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection d) => {},
          background: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(width: BelchCard.HEIGHT / 3),
                Icon(Icons.delete,
                    color: Colors.red, size: BelchCard.HEIGHT / 3),
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
                    color: Colors.red, size: BelchCard.HEIGHT / 3),
                Container(width: BelchCard.HEIGHT / 3),
              ],
            ),
          ),
          child: BelchCard(filenames[index]),
        );
      },
    );
  }
}
