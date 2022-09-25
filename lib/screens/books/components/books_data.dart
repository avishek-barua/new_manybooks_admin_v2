import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../models/RecentFile.dart';
import '../../../models/books/books_dummy.dart';

class BooksData extends StatefulWidget {
  final List<Book> bookList;
  const BooksData({required this.bookList, Key? key}) : super(key: key);

  @override
  State<BooksData> createState() => _BooksDataState();
}

class _BooksDataState extends State<BooksData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Author List',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(label: Text('Book Name')),
                  DataColumn(label: Text('Author Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Genre')),
                  // DataColumn(label: Text('File')),
                  // DataColumn(label: Text('Cover')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Reject Reason')),
                  DataColumn(label: Text('Language')),
                  DataColumn(label: Text('Share')),
                  // DataColumn(label: Text('UserId')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(widget.bookList.length,
                    (index) => bookDataRow(widget.bookList[index]))),
          )
        ],
      ),
      // ListView.builder(itemBuilder: (ctx, i)=> ListTile(
      //   title: Text(widget.authorList[i].name),
      //   subtitle: Text(widget.authorList[i].description),
      // ))
    );
  }

  DataRow bookDataRow(Book book) {
    return DataRow(cells: [
      DataCell(Text(book.name)),
      DataCell(Text(book.author)),
      DataCell(Text(book.description)),
      DataCell(Text(book.genre)),
      // DataCell(Text(book.file)),
      // DataCell(Text(book.cover)),
      DataCell(Text(book.status)),
      DataCell(Text(book.rejectReason)),
      DataCell(Text(book.language)),
      DataCell(Text(book.shares)),
      // DataCell(Text(book.userId)),
      DataCell(Row(
        children: [
          ElevatedButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Create Atuthor'),
                      content: AuthorForm(),
                    ),
                  ),
              child: Icon(Icons.edit)),
          ElevatedButton(
              onPressed: () async {
                var headers = {
                  'Authorization':
                      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzAxMDE0MTZhNTFmNTQ0OGVmZDExZGYiLCJlbWFpbCI6Im1vbWluQGdtYWlsLmNvbSIsImlhdCI6MTY2MTAxMDI0MSwiZXhwIjoxNjYxMDEzMjQxfQ.kN5lst8oI6Kt1vxr-z9f1m9YN3GzHRv9RfbTxxKTNRI'
                };
                var request = http.Request('DELETE',
                    Uri.parse('http://localhost:8000/books/${book.id}'));

                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  print(await response.stream.bytesToString());
                } else {
                  print(response.reasonPhrase);
                }
              },
              child: Icon(
                Icons.delete,
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red))),
        ],
      ))
    ]);
  }
}

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
