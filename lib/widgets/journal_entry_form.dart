import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dropdown_rating_form_field.dart';
import '../db/database_manager.dart';
import '../db/journal_entry_dto.dart';

class JournalEntryForm extends StatefulWidget {
  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryDTO = JournalEntryDTO(
      title: "initial", body: "initial", rating: 0, datetime: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Title', border: OutlineInputBorder()),
                onSaved: (value) {
                  //save journal entry titles
                  journalEntryDTO.title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // TODO: implement saving in database
                      // Database.of(context).saveJournalEntry(journalEntryDTO);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save Entry'))
            ])));
  }

  Widget formContent(BuildContext context) {
    return Text("");
  }

  Widget titleTextField() {
    return Text("");
  }

  Widget bodyTextField() {
    return Text("");
  }

  Widget ratingDropdown() {
    return Text("");
  }

  Widget buttons(BuildContext context) {
    return Text("");
  }

  Widget cancelButton(BuildContext context) {
    return ElevatedButton(child: Text('Cancel'), onPressed: () {});
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
        child: Text('Save entry'),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            addDateToJournalEntryValues();
            final databaseManager = DatabaseManager.getInstance();
            databaseManager.saveJournalEntry(journalEntryDTO);
            // no need to close the db
            Navigator.of(context).pop();
          }
        });
  }

  void addDateToJournalEntryValues() {
    // assign current time
    journalEntryDTO.datetime =
        DateFormat.yMMMMd('en_US').format(DateTime.now()).toString();
  }
}
