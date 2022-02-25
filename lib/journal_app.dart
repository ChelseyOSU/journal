import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';
import 'screens/journal_entry_list.dart';
import 'models/journal.dart';
import 'db/journal_entry_dto.dart';
import 'db/database_manager.dart';
import 'widgets/journal_scaffold.dart';

class JournalApp extends StatefulWidget {
  // set up shared preferences
  SharedPreferences? preferences;

  JournalApp({Key? key, this.preferences}) : super(key: key);

  @override
  State<JournalApp> createState() => JournalAppState();
}

class JournalAppState extends State<JournalApp> {
  Journal? journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntryDTO> journalEntries =
        await databaseManager.journalEntries();
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      // show widget for loading journal
      return CircularProgressIndicator();
    } else {
      if (journal!.noItemsInJournal()) {
        // if there's no entries, show the welcome page
        return JournalScaffold(
            title: 'Welcome to Journal app', body: Welcome());
      } else {
        return JournalScaffold(
            title: 'Entries', body: JournalEntryList(journal: journal));
      }
    }
  }
}
