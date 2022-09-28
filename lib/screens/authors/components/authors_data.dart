import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../models/RecentFile.dart';
import '../../../models/author/author.dart';
import '../../../models/states/state.dart';
import '../../../utils/api_callings.dart';

class AuthorsData extends StatefulWidget {
  final List<Author> authorList;
  const AuthorsData({required this.authorList, Key? key}) : super(key: key);

  @override
  State<AuthorsData> createState() => _AuthorsDataState();
}

class _AuthorsDataState extends State<AuthorsData> {
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(label: Text('Author Name')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Birth')),
                    DataColumn(label: Text('Death')),
                    DataColumn(label: Text('Wikipedia')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List.generate(widget.authorList.length,
                      (index) => authorDataRow(widget.authorList[index]))),
            ),
          ),
        ],
      ),
      // ListView.builder(itemBuilder: (ctx, i)=> ListTile(
      //   title: Text(widget.authorList[i].name),
      //   subtitle: Text(widget.authorList[i].description),
      // ))
    );
  }

  DataRow authorDataRow(Author author) {
    return DataRow(cells: [
      DataCell(Text(author.name)),
      DataCell(Text(author.description)),
      DataCell(Text(author.birth)),
      DataCell(Text(author.death)),
      DataCell(Text(author.wikipedia)),
      DataCell(Row(
        children: [
          ElevatedButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Create Atuthor'),
                      content: AuthorForm(
                        author: author,
                      ),
                    ),
                  ),
              child: Icon(Icons.edit)),
          ElevatedButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete'),
                      content:
                          Text('Do you really want to delete ${author.name}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var headers = {
                              'Authorization':
                                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzAxMDE0MTZhNTFmNTQ0OGVmZDExZGYiLCJlbWFpbCI6Im1vbWluQGdtYWlsLmNvbSIsImlhdCI6MTY2MTAxMDI0MSwiZXhwIjoxNjYxMDEzMjQxfQ.kN5lst8oI6Kt1vxr-z9f1m9YN3GzHRv9RfbTxxKTNRI'
                            };
                            var request = http.Request(
                                'DELETE',
                                Uri.parse(
                                    'http://localhost:8000/authors/${author.id}'));

                            request.headers.addAll(headers);

                            http.StreamedResponse response =
                                await request.send();

                            if (response.statusCode == 200) {
                              print(await response.stream.bytesToString());
                            } else {
                              print(response.reasonPhrase);
                            }

                            List<Author> authorList =
                                await ApiCalling.getAllAuthors();
                            statesContainer.state.setAuthorList(authorList);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
              // onPressed: () async {
              //   var headers = {
              //     'Authorization':
              //         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzAxMDE0MTZhNTFmNTQ0OGVmZDExZGYiLCJlbWFpbCI6Im1vbWluQGdtYWlsLmNvbSIsImlhdCI6MTY2MTAxMDI0MSwiZXhwIjoxNjYxMDEzMjQxfQ.kN5lst8oI6Kt1vxr-z9f1m9YN3GzHRv9RfbTxxKTNRI'
              //   };
              //   var request = http.Request('DELETE',
              //       Uri.parse('http://localhost:8000/authors/${author.id}'));

              //   request.headers.addAll(headers);

              //   http.StreamedResponse response = await request.send();

              //   if (response.statusCode == 200) {
              //     print(await response.stream.bytesToString());
              //   } else {
              //     print(response.reasonPhrase);
              //   }

              //   List<Author> authorList = await ApiCalling.getAllAuthors();
              //   statesContainer.state.setAuthorList(authorList);
              // },
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
  final Author author;
  const AuthorForm({required this.author, Key? key}) : super(key: key);

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
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = widget.author.name;
    avatarController.text = widget.author.avatar;
    descriptionController.text = widget.author.description;
    birthController.text = widget.author.birth;
    deathController.text = widget.author.death;
    wikipediaController.text = widget.author.wikipedia;
  }

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
