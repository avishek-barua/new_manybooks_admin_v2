// To parse this JSON data, do
//
//     final authorGetResponse = authorGetResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'author.dart';

class AuthorGetResponse {
    AuthorGetResponse({
        required this.data,
        required this.total,
    });

    final List<Book>? data;
    final int total;

    factory AuthorGetResponse.fromRawJson(String str) => AuthorGetResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthorGetResponse.fromJson(Map<String, dynamic> json) => AuthorGetResponse(
        data: json["data"] == null ? null : List<Book>.from(json["data"].map((x) => Book.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total == null ? null : total,
    };
}

// class AuthorModel {
//     AuthorModel({
//         required this.id,
//         required this.name,
//         required this.avatar,
//         required this.description,
//         required this.birth,
//         required this.death,
//         required this.wikipedia,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     final String id;
//     final String name;
//     final String avatar;
//     final String description;
//     final String birth;
//     final String death;
//     final String wikipedia;
//     final String createdAt;
//     final String updatedAt;
//     final int v;

//     factory AuthorModel.fromRawJson(String str) => AuthorModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
//         id: json["_id"] == null ? null : json["_id"],
//         name: json["name"] == null ? null : json["name"],
//         avatar: json["avatar"] == null ? null : json["avatar"],
//         description: json["description"] == null ? null : json["description"],
//         birth: json["birth"] == null ? null : json["birth"],
//         death: json["death"] == null ? null : json["death"],
//         wikipedia: json["wikipedia"] == null ? null : json["wikipedia"],
//         createdAt: json["createdAt"] == null ? null : json["createdAt"],
//         updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
//         v: json["__v"] == null ? null : json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "avatar": avatar == null ? null : avatar,
//         "description": description == null ? null : description,
//         "birth": birth == null ? null : birth,
//         "death": death == null ? null : death,
//         "wikipedia": wikipedia == null ? null : wikipedia,
//         "createdAt": createdAt == null ? null : createdAt,
//         "updatedAt": updatedAt == null ? null : updatedAt,
//         "__v": v == null ? null : v,
//     };
// }
