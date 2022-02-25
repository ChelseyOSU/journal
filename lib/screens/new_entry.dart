import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/journal_drawer.dart';
import '../journal_app.dart';
import '../db/journal_entry_dto.dart';
import '../db/database_manager.dart';

class NewEntry extends StatefulWidget {
  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  // need to use form key for access form information
  int choosenRating = 1;
  final formKey = GlobalKey<FormState>();
  JournalEntryDTO dto = JournalEntryDTO(
      title: "initial", body: "initial", rating: 0, datetime: "");

  // need to
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: JournalDrawer(),
        appBar: AppBar(
            title: Text('New Journal Entry'),
            centerTitle: true,
            leading: Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => {Navigator.of(context).pop()})),
            actions: <Widget>[
              Builder(
                  builder: (context) => IconButton(
                      icon: Icon(Icons.settings, color: Colors.white),
                      onPressed: () => {Scaffold.of(context).openEndDrawer()}))
            ]),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      journalEntryForm(
                          context: context,
                          label: 'Title',
                          errorMessage: 'Please enter a Title',
                          onSaved: (value) {
                            dto.title = value;
                          },
                          type: TextInputType.text),
                      journalEntryForm(
                          context: context,
                          label: 'Body',
                          errorMessage: 'Please enter a Body',
                          onSaved: (value) {
                            dto.body = value;
                          },
                          type: TextInputType.text),
                      Container(
                          margin: EdgeInsets.all(5.0),
                          width: getOrientation(context),
                          child: DropdownButtonFormField<int>(
                            value: choosenRating,
                            items: ratingMenuItems(maxRating: 4),
                            onChanged: (menuItem) {
                              setState(() => choosenRating = menuItem!);
                            },
                            decoration: InputDecoration(
                              labelText: 'Rating',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a Rating';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              dto.rating = value as int;
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 90,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.blueGrey)),
                                  onPressed: () =>
                                      {Navigator.of(context).pop()},
                                  child: Text('Cancel'))),
                          Container(
                              width: 90,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.blueGrey)),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      final databaseManager =
                                          DatabaseManager.getInstance();
                                      dto.datetime = DateFormat.yMMMMd('en_US')
                                          .format(DateTime.now())
                                          .toString(); //DateTime.now();
                                      databaseManager.saveJournalEntry(dto);
                                      JournalAppState journalAppState =
                                          context.findAncestorStateOfType<
                                                  JournalAppState>()
                                              as JournalAppState;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => JournalApp(
                                                  preferences: journalAppState
                                                      .widget.preferences)));
                                    }
                                  },
                                  child: Text('Save'))),
                        ],
                      )
                    ]))));
  }

  Widget journalEntryForm(
      {required BuildContext context, label, errorMessage, onSaved, type}) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: TextFormField(
            autofocus: false,
            keyboardType: type,
            decoration: InputDecoration(
                labelText: label,
                contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                border: OutlineInputBorder()),
            onSaved: onSaved,
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              } else {
                return null;
              }
            }));
  }

  List<DropdownMenuItem<int>> ratingMenuItems({required int maxRating}) {
    return List<DropdownMenuItem<int>>.generate(maxRating, (i) {
      return DropdownMenuItem<int>(value: i + 1, child: Text('${i + 1}'));
    });
  }

  double getOrientation(BuildContext context) {
    var query = MediaQuery.of(context);
    return query.orientation == Orientation.landscape
        ? query.size.width * 0.95
        : query.size.width * 0.9;
  }
}
