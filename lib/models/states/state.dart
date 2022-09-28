import 'package:manybooks_admin_v2/models/author/author.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:http/http.dart' as http;

import '../../models/books/books_dummy.dart';

class StatesContainer {
  //Always plain dart class
  List<Book> bookList = [];
  List<Author> authorList = [];

  setBookList(List<Book> bookList) {
    this.bookList = bookList;
    print(bookList);
    statesContainer.notify();
  }

  setAuthorList(List<Author> authorList) {
    this.authorList = authorList;
    print(authorList);
    statesContainer.notify();
  }

// Make it global to access it from any classes
}

final statesContainer = RM.inject(() => StatesContainer());
