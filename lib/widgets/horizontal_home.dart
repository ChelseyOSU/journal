import 'package:flutter/material.dart';
import '../screens/new_entry.dart';
import '../models/journal.dart';

class HorizontalHome extends StatefulWidget {
  Journal? journal;

  HorizontalHome({required this.journal});

  @override
  _HorizontalHomeState createState() => _HorizontalHomeState();
}

class _HorizontalHomeState extends State<HorizontalHome> {
  String addedTitle = '';
  String addedBody = '';

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: ListView.builder(
            itemCount: widget.journal!.entries.length,
            itemBuilder: (context, index) {
              return ListTile(
                  trailing: Icon(Icons.more_horiz),
                  title: Text(widget.journal!.entries[index].title),
                  subtitle: Text(widget.journal!.entries[index].datetime),
                  onTap: () {
                    setState(() {
                      addedTitle = widget.journal!.entries[index].title;
                      addedBody = widget.journal!.entries[index].body;
                    });
                  });
            }),
      ),
      Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
            SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(addedTitle, style: TextStyle(fontSize: 40.00)),
                  Text(addedBody),
                  Container(height: 250)
                ])),
            Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(), primary: Colors.blueAccent),
                    onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewEntry()))
                        },
                    child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.add))))
          ]))
    ]);
  }
}
