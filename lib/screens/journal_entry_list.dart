import 'package:flutter/material.dart';
import '../widgets/vertical_home.dart';
import '../widgets/horizontal_home.dart';
import '../models/journal.dart';

class JournalEntryList extends StatefulWidget {
  Journal? journal;

  // journal is required
  JournalEntryList({required this.journal});

  @override
  State<JournalEntryList> createState() => _JournalEntryListState();
}

class _JournalEntryListState extends State<JournalEntryList> {
  Journal? journal;

  @override
  Widget build(BuildContext context) {
    if (widget.journal == null) {
      // if journal is not loaded yet, display a progress indicator
      return CircularProgressIndicator(
          semanticsLabel: "Loading journal Entries");
    } else {
      // depends on whether vertical or horizontal, show different layouts
      return LayoutBuilder(builder: horizontalOrVerical);
    }
  }

  Widget horizontalOrVerical(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 400
        ? VerticalHome(journal: widget.journal)
        : HorizontalHome(journal: widget.journal);
  }
}
