import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../models/RecentFile.dart';
import '../../../models/author.dart';

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
          )
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
          ElevatedButton(onPressed: () {}, child: Icon(Icons.edit)),
          ElevatedButton(
              onPressed: () {},
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
