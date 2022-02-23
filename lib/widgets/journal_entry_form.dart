import 'dart:html';

import 'package:flutter/material.dart';

class JournalEntryFields {
  String ? title = "";
  String body = "";
  DateTime datetime = DateTime.now();
  int rating = 0;
  String toString() {
    return 'Title: $title, Body: $body, Time: $datetime, Rating: $rating';
  }
}

class JournalEntryForm extends StatefulWidget {
  @override
  State<JournalEntryForm> createState() => _JournalEntryFormState();
}

class _JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder()
                ),
                onSaved: (value) {
                  //save journal entry titles
                  journalEntryFields.title = value;
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
                    // Database.of(context).saveJournalEntry(journalEntryFields);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Entry')
              )
            ]
          ))
    );
  }
}