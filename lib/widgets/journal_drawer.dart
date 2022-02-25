import 'package:flutter/material.dart';
import '../journal_app.dart';
import 'journal_scaffold.dart';

class JournalDrawer extends StatefulWidget {
  @override
  _JournalDrawerState createState() => _JournalDrawerState();
}

class _JournalDrawerState extends State<JournalDrawer> {
  late bool sliderValue;

  @override
  void initState() {
    super.initState();
    initSliderValue();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      Container(height: 60, child: DrawerHeader(child: Text('Settings'))),
      SwitchListTile(
          title: Text('Dark Mode or Light Mode'),
          value: sliderValue,
          onChanged: (bool newSliderValue) {
            JournalScaffoldState scaffoldState =
                context.findAncestorStateOfType<JournalScaffoldState>()
                    as JournalScaffoldState;
            JournalAppState appState = context
                .findAncestorStateOfType<JournalAppState>() as JournalAppState;
            newSliderValue
                ? appState.widget.preferences!.setString('brightness', 'dark')
                : appState.widget.preferences!.setString('brightness', 'light');
            setState(() {
              sliderValue = newSliderValue;
              scaffoldState.setBrightness();
            });
          })
    ]));
  }

  void initSliderValue() {
    setState(() {
      JournalAppState appState =
          context.findAncestorStateOfType<JournalAppState>() as JournalAppState;
      String dbValue =
          appState.widget.preferences!.getString('brightness') as String;
      sliderValue = dbValue == 'dark' ? true : false;
    });
  }
}
