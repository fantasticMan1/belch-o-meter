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
          key: Key(filenames[index]),
          background: Container(
            color: Colors.redAccent,
            child: Row(
              children: [
                Container(width: 20),
                Icon(Icons.delete),
                Expanded(child: Container()),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.redAccent,
            child: Row(
              children: [
                Expanded(child: Container()),
                Icon(Icons.delete),
                Container(width: 20),
              ],
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              // Item was discarded
              setState(() {
                filenames.removeAt(index);
              });

              // TODO: undo option
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("${filenames[index]} deleted")));
            } else if (direction == DismissDirection.startToEnd) {
              // Item was favorited
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("${filenames[index]} liked")));
            }
          },
          child: BelchCard(filenames[index]),
        );
      },
    );
  }
}
