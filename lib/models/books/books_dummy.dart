// To parse this JSON data, do
//
//     final booksResponse = booksResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class BooksResponse {
    BooksResponse({
        required this.data,
        required this.total,
    });

    final List<Book>? data;
    final int total;

    factory BooksResponse.fromRawJson(String str) => BooksResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BooksResponse.fromJson(Map<String, dynamic> json) => BooksResponse(
        data: json["data"] == null ? null : List<Book>.from(json["data"].map((x) => Book.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total == null ? null : total,
    };
}

class Book {
    Book({
        required this.id,
        required this.name,
        required this.author,
        required this.description,
        required this.genre,
        required this.file,
        required this.cover,
        required this.status,
        required this.rejectReason,
        required this.numberOfPages,
        required this.language,
        required this.shares,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final String name;
    final String author;
    final String description;
    final String genre;
    final String file;
    final String cover;
    final String status;
    final String rejectReason;
    final String numberOfPages;
    final String language;
    final String shares;
    final String userId;
    final String createdAt;
    final String updatedAt;
    final int v;

    factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        author: json["author"] == null ? null : json["author"],
        description: json["description"] == null ? null : json["description"],
        genre: json["genre"] == null ? null : json["genre"],
        file: json["file"] == null ? null : json["file"],
        cover: json["cover"] == null ? null : json["cover"],
        status: json["status"] == null ? null : json["status"],
        rejectReason: json["rejectReason"] == null ? null : json["rejectReason"],
        numberOfPages: json["numberOfPages"] == null ? null : json["numberOfPages"],
        language: json["language"] == null ? null : json["language"],
        shares: json["shares"] == null ? null : json["shares"],
        userId: json["userId"] == null ? null : json["userId"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "author": author == null ? null : author,
        "description": description == null ? null : description,
        "genre": genre == null ? null : genre,
        "file": file == null ? null : file,
        "cover": cover == null ? null : cover,
        "status": status == null ? null : status,
        "rejectReason": rejectReason == null ? null : rejectReason,
        "numberOfPages": numberOfPages == null ? null : numberOfPages,
        "language": language == null ? null : language,
        "shares": shares == null ? null : shares,
        "userId": userId == null ? null : userId,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
    };
}
