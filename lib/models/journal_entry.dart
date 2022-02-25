import 'package:flutter/material.dart';

class JournalEntry {
  JournalEntry(
      {required this.title,
      required this.body,
      required this.rating,
      required this.datetime});

  String title = '';
  String body = '';
  int rating = 0;
  String datetime = "";

  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Time: $datetime';
  }
}
