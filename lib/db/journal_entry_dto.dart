class JournalEntryDTO {

  String title = "";
  String body = "";
  String datetime = "";
  int rating = 0;

  // constructor require all fields
  JournalEntryDTO({required this.title, required this.body, required this.datetime, required this.rating});
 
  String toString() {
    return 'Title: $title, Body: $body, Rating: $rating, Time: $datetime';
  }
}