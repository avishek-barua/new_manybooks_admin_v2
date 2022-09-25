import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../models/RecentFile.dart';
import '../../../models/author/author.dart';
import '../../../models/user/user_dummy.dart';

class UsersData extends StatefulWidget {
  final List<User> userList;
  const UsersData({required this.userList, Key? key}) : super(key: key);

  @override
  State<UsersData> createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
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
                  DataColumn(label: Text('User Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(widget.userList.length,
                    (index) => userDataRow(widget.userList[index]))),
          )
        ],
      ),
      // ListView.builder(itemBuilder: (ctx, i)=> ListTile(
      //   title: Text(widget.authorList[i].name),
      //   subtitle: Text(widget.authorList[i].description),
      // ))
    );
  }

  DataRow userDataRow(User user) {
    return DataRow(cells: [
      DataCell(Text(user.name)),
      DataCell(Text(user.email)),
      DataCell(Row(
        children: [
          ElevatedButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Edit Atuthor'),
                      content: UserForm(),
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
                    Uri.parse('http://localhost:8000/users/${user.id}'));

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

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
                  labelText: 'User Name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
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
                  onPressed: () {
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
