import '../db/journal_entry_dto.dart';
import 'journal_entry.dart';

class Journal {
  // Journal object is just a list of journal entries
  List<JournalEntryDTO> entries;

  // entries are required in the constructor
  Journal({required this.entries});

  // verify if Journal is empty or not
  bool noItemsInJournal() {
    if (entries.length == 0) {
      return true;
    }
    return false;
  }
}
