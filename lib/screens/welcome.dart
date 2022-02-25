import 'package:flutter/material.dart';
import 'new_entry.dart';

// welcome screen will be displayed when no entries are found
// it also displays an add button on the bottom right to add entries
class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.book_sharp, size: 200),
        Text('Welcome to Journal app!'),
        Container(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewEntry()));
                },
                child: Icon(Icons.add_circle))),
      ],
    );
  }
}
