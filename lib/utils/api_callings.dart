import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/after_login.dart';
import '../models/author/author.dart';
import '../models/author/author_dummy.dart';
import '../models/books/books_dummy.dart';

const API_ENDPOINT = 'http://192.168.1.143:8000';

// neo home ip
// const API_ENDPOINT = 'http://192.168.0.107:8000';

class ApiCalling {
  static Future<String?> login(AfterLogin afterLogin) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("$API_ENDPOINT/users/login"));
    request.body = json.encode({
      "email": afterLogin.email,
      "name": afterLogin.displayName,
      "token": afterLogin.token,
      "tokenType": afterLogin.tokenType
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode < 400) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }


static Future<List<Book>> getAllBooks() async {
  // var bookList;
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA1ZTM2NzQzNzE5ZGU3ZTA2M2E2ZDQiLCJlbWFpbCI6Im1vbWludWxrYXJpbTk3QGdtYWlsLmNvbSIsImlhdCI6MTY2MzU3MTU3MSwiZXhwIjoxNjYzNTc0NTcxfQ.2DS4rFMiAB5pU5jAlljDgIfSz5RXtSKsoc7YNQNWTWc'
  };
  var request = http.Request('Get', Uri.parse('http://localhost:8000/books/'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String jsonResponse = await response.stream.bytesToString();

    BooksResponse bookResponse = BooksResponse.fromRawJson(jsonResponse);

    // var authors = authorResponse.data!.toList();

    // // print(authors[0]);
    // print(authors[0]['name']);
    // print(authorResponse.data);

    print('hello');
    return bookResponse.data!;

    // List<AuthorResponse> authorRespose =
    //     await Helper.convertAuthorJsonToList(jsonResponse);
    // print(authorRespose);
  } else {
    print(response.reasonPhrase);
    return [];
  }
}

static Future<List<Author>> getAllAuthors() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA1ZTM2NzQzNzE5ZGU3ZTA2M2E2ZDQiLCJlbWFpbCI6Im1vbWludWxrYXJpbTk3QGdtYWlsLmNvbSIsImlhdCI6MTY2MzU3MTU3MSwiZXhwIjoxNjYzNTc0NTcxfQ.2DS4rFMiAB5pU5jAlljDgIfSz5RXtSKsoc7YNQNWTWc'
    };
    var request =
        http.Request('Get', Uri.parse('http://localhost:8000/authors/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();

      AuthorGetResponse authorResponse =
          AuthorGetResponse.fromRawJson(jsonResponse);

      // var authors = authorResponse.data!.toList();

      // // print(authors[0]);
      // print(authors[0]['name']);
      print(authorResponse.data);

        return authorResponse.data!;

      // List<AuthorResponse> authorRespose =
      //     await Helper.convertAuthorJsonToList(jsonResponse);
      // print(authorRespose);
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

}