import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:http/http.dart' as http;

import '../author.dart';
import '../author_dummy.dart';

class StatesContainer {
  //Always plain dart class

  List<Author> authorList = [];

  // Future<void> getAllAuthors() async {
  //   var headers = {
  //     'Authorization':
  //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA1ZTM2NzQzNzE5ZGU3ZTA2M2E2ZDQiLCJlbWFpbCI6Im1vbWludWxrYXJpbTk3QGdtYWlsLmNvbSIsImlhdCI6MTY2MzU3MTU3MSwiZXhwIjoxNjYzNTc0NTcxfQ.2DS4rFMiAB5pU5jAlljDgIfSz5RXtSKsoc7YNQNWTWc'
  //   };
  //   var request =
  //       http.Request('Get', Uri.parse('http://localhost:8000/authors/'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     String jsonResponse = await response.stream.bytesToString();

  //     AuthorGetResponse authorResponse =
  //         AuthorGetResponse.fromRawJson(jsonResponse);

  //     // var authors = authorResponse.data!.toList();

  //     // // print(authors[0]);
  //     // print(authors[0]['name']);
  //     // print(authorResponse.data);

  //     authorList = authorResponse.data!;
  //     print('hello');

  //     // List<AuthorResponse> authorRespose =
  //     //     await Helper.convertAuthorJsonToList(jsonResponse);
  //     // print(authorRespose);
  //     // } else {
  //     //   print(response.reasonPhrase);
  //     // }
  //   }
  //   statesContainer.notify();
  // }

// class StatesContainer { //Always plain dart class
//   int counter = 0;

//   increase(int number) {
//     counter += number;
//     statesContainer.notify(); // used instead of rebuildStates()
//   }
// }

// Make it global to access it from any classes
}

final statesContainer = RM.inject(() => StatesContainer());
