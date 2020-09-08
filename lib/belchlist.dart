import 'package:flutter/material.dart';
import 'belchcard.dart';

class BelchList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BelchListState();
}

class BelchListState extends State {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BelchCard(title: 'Belch no. 1'),
        BelchCard(title: 'Belch no. 2'),
        BelchCard(title: 'Belch no. 3'),
      ],
    );
  }
}
