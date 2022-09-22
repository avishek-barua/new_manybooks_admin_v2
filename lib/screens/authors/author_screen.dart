// import 'dart:html';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../helper/helper.dart';
import '../../models/author.dart';
import '../../responsive.dart';
import '../dashboard/components/header.dart';
import '../dashboard/components/my_files.dart';
import '../dashboard/components/recent_files.dart';
import '../dashboard/components/storage_details.dart';
import '../../models/author_dummy.dart';
import 'components/authors_data.dart';

class AuthorScreen extends StatefulWidget {
  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  List<Author> authorList = [];
  @override
  void initState() {
    super.initState();
    getAllAuthors();
  }

  Future<void> getAllAuthors() async {
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

      setState(() {
        authorList = authorResponse.data!;
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
                          Text('Author',
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
                                      title: const Text('Create Atuthor'),
                                      content: AuthorForm(),
                                    ),
                                  ),
                              icon: Icon(Icons.add),
                              label: Text("Add New")),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      AuthorsData(authorList: authorList),
                      // ListView.builder(
                      //   itemBuilder: (ctx, i) => ListTile(
                      //     title: Text(authorList[i].name),
                      //     subtitle: Text(authorList[i].description),
                      //   ),
                      // )
                    ],
                  ),
                ),
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

class AuthorForm extends StatefulWidget {
  const AuthorForm({Key? key}) : super(key: key);

  @override
  State<AuthorForm> createState() => _AuthorFormState();
}

class _AuthorFormState extends State<AuthorForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController avatarController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController deathController = TextEditingController();
  TextEditingController wikipediaController = TextEditingController();
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
                  labelText: 'Author Name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: avatarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Avatar',
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
                  labelText: 'Description',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: birthController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birth',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: deathController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Death',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: wikipediaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Wikipedia',
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
                          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzA3MTNjNDZiYWE0NWMxZDk0NTQ3ZDkiLCJlbWFpbCI6ImN5Ym9yZ0B6ZXJvZGF5LmNvbSIsImlhdCI6MTY2MTQwODE5NiwiZXhwIjoxNjYxNDExMTk2fQ.swrfL9LTwISXLew19wwXmka4selyc6xht1SWuf_lRk0',
                      'Content-Type': 'application/x-www-form-urlencoded',
                    };
                    var request = http.Request(
                        'POST', Uri.parse('http://localhost:8000/authors/'));
                    request.bodyFields = {
                      'name': nameController.text,
                      'avatar': avatarController.text,
                      'description': descriptionController.text,
                      'birth': birthController.text,
                      'death': deathController.text,
                      'wikipedia': wikipediaController.text
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
