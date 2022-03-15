
import 'item.dart';

class Category implements Item {
  String? name;
  String? author;
  String? date;
  String? description;
  String? questionslink;
  String? magic;
  Category.empty() {
    magic = DateTime.now().millisecondsSinceEpoch.toString();
    
  }
  Category(
      {this.name,
      this.author,
      this.date,
      this.description,
      this.questionslink,
      this.magic}) {
    magic = DateTime.now().millisecondsSinceEpoch.toString();
  }

  setName(String name) {
    this.name = name;
  }

  String getMagic() {
    return magic as String;
  }

  setMagic(String text) {
    magic = text;
  }

  setDescription(String description) {
    this.description = description;
  }

  setAuthor(String author) {
    this.author = author;
  }

  setDate(String date) {
    this.date = date;
  }

  setQuestionsLink(String link) {
    questionslink = link;
  }

  // Category(
  //     this.name, this.author, this.date, this.description, this.questionslink);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "author": author,
      "date": date,
      "description": description,
      "questionslink": questionslink,
      "magic": magic,
    };
    return map;
  }

  @override
  fromMap(Map<String, dynamic> map) {
    name = map['name'];
    author = map['author'];
    date = map['date'];
    description = map['description'];
    questionslink = map['questionslink'];
    magic = map['magic'];
  }

  @override
  empty() {
    return Category.empty();
  }

  @override
  String? ref;
}
