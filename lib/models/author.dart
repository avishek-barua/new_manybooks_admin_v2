// To parse this JSON data, do
//
//     final author = authorFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Author {
    Author({
       required this.id,
       required this.name,
       required this.avatar,
       required this.description,
       required this.birth,
       required this.death,
       required this.wikipedia,
    });

    final String id;
    final String name;
    final String avatar;
    final String description;
    final String birth;
    final String death;
    final String wikipedia;

    factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        description: json["description"] == null ? null : json["description"],
        birth: json["birth"] == null ? null : json["birth"],
        death: json["death"] == null ? null : json["death"],
        wikipedia: json["wikipedia"] == null ? null : json["wikipedia"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "avatar": avatar == null ? null : avatar,
        "description": description == null ? null : description,
        "birth": birth == null ? null : birth,
        "death": death == null ? null : death,
        "wikipedia": wikipedia == null ? null : wikipedia,
    };
}
