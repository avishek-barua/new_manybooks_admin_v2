// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:manybooks_admin_v2/screens/books/components/books_data.dart';

import '../../models/books/books_dummy.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/my_files.dart';
import '../dashboard/components/storage_details.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/my_files.dart';
import '../dashboard/components/recent_files.dart';
import '../dashboard/components/storage_details.dart';
import '../../constants.dart';

class BookScreen extends StatefulWidget {
  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<Book> bookList= [];
  @override
  void initState() {
    super.initState();
    getAllBooks();
  }

  Future<void> getAllBooks() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA1ZTM2NzQzNzE5ZGU3ZTA2M2E2ZDQiLCJlbWFpbCI6Im1vbWludWxrYXJpbTk3QGdtYWlsLmNvbSIsImlhdCI6MTY2MzU3MTU3MSwiZXhwIjoxNjYzNTc0NTcxfQ.2DS4rFMiAB5pU5jAlljDgIfSz5RXtSKsoc7YNQNWTWc'
    };
    var request =
        http.Request('Get', Uri.parse('http://localhost:8000/books/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();

      BooksResponse bookResponse =
          BooksResponse.fromRawJson(jsonResponse);

      // var authors = authorResponse.data!.toList();

      // // print(authors[0]);
      // print(authors[0]['name']);
      // print(authorResponse.data);

      setState(() {
        bookList = bookResponse.data!;
      });
      print('hello');

      // List<AuthorResponse> authorRespose =
      //     await Helper.convertAuthorJsonToList(jsonResponse);
      // print(authorRespose);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Books',
                                style: Theme.of(context).textTheme.subtitle1),
                            ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding /
                                        (Responsive.isMobile(context) ? 2 : 1),
                                  ),
                                ),
                                onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Create Book'),
                                        content: BookForm(),
                                      ),
                                    ),
                                icon: Icon(Icons.add),
                                label: Text("Add New")),
                          ],
                        ),
                        SizedBox(height: defaultPadding),
                        BooksData(bookList: bookList)
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class DialogExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('AlertDialog Title'),
//           content: const Text('AlertDialog description'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//       child: const Text('Show Dialog'),
//     );
//   }
// }

class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController numberOfPagesController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  // 'file': '123',
  // 'cover': '123',
  // 'numberOfPages': '123',
  // 'language': 'bn'
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Book Name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Book Description',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: genreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Genre',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: numberOfPagesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number of pages',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: languageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Language',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    var headers = {
                      'Authorization':
                          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA1YjU2Y2ViNTgwMjU3Y2NmOWZhM2UiLCJlbWFpbCI6Im1vbWluQGdtYWlsLmNvbSIsImlhdCI6MTY2MTMxODUwOCwiZXhwIjoxNjYxMzIxNTA4fQ.YXq81VPwUfO-NFH3kVMgNW87UkNG6H2uFR14U351Yow',
                      'Content-Type': 'application/x-www-form-urlencoded'
                    };
                    var request = http.Request(
                        'POST', Uri.parse('http://localhost:8000/books/'));
                    request.bodyFields = {
                      'name': nameController.text,
                      'authorId': '630713e6dd0bf1707e3cd0fb',
                      'description': descriptionController.text,
                      'genre': genreController.text,
                      'file': '123',
                      'cover': '123',
                      'numberOfPages': numberOfPagesController.text,
                      'language': languageController.text
                    };
                    request.headers.addAll(headers);

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                    } else {
                      print(response.reasonPhrase);
                    }

                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
