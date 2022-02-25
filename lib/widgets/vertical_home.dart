import 'package:flutter/material.dart';
import '../screens/journal_entry.dart';
import '../screens/new_entry.dart';
import '../models/journal.dart';

class VerticalHome extends StatefulWidget {
  Journal? journal;

  VerticalHome({required this.journal});

  @override
  _VerticalHomeState createState() => _VerticalHomeState();
}

class _VerticalHomeState extends State<VerticalHome> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      ListView.builder(
          itemCount: widget.journal!.entries.length,
          itemBuilder: (context, index) {
            return ListTile(
                trailing: Icon(Icons.more_sharp),
                title: Text(widget.journal!.entries[index].title),
                subtitle: Text(widget.journal!.entries[index].datetime),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JournalEntry(
                          title: widget.journal!.entries[index].title,
                          body: widget.journal!.entries[index].body,
                          date: widget.journal!.entries[index].datetime)));
                });
          }),
      Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), primary: Colors.blueAccent),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NewEntry();
                }));
              },
              child: Container(
                child: Icon(Icons.add_circle),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
              )))
    ]);
  }
}
