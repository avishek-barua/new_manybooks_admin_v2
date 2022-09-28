

import 'dart:convert';


import '../models/author/author.dart';
import '../models/author/author_dummy.dart';

class Helper {
  static convertAuthorJsonToList(jsonStr) {
    final List t = json.decode(jsonStr);
    final List<Author> portasAbertasList =
        t.map((item) => Author.fromJson(item)).toList();
    return portasAbertasList;
  }
}
