

import 'dart:convert';


import '../models/author/author.dart';
import '../models/author/author_dummy.dart';

class Helper {
  static convertAuthorJsonToList(jsonStr) {
    final List t = json.decode(jsonStr);
    final List<Book> portasAbertasList =
        t.map((item) => Book.fromJson(item)).toList();
    return portasAbertasList;
  }
}
