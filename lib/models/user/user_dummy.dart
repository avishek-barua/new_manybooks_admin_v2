// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserResponse {
    UserResponse({
        required this.data,
        required this.total,
    });

    final List<User>? data;
    final int total;

    factory UserResponse.fromRawJson(String str) => UserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: json["data"] == null ? null : List<User>.from(json["data"].map((x) => User.fromJson(x))),
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total == null ? null : total,
    };
}

class User {
    User({
        required this.id,
        required this.email,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
        required this.name,
    });

    final String id;
    final String email;
    final int v;
    final String createdAt;
    final String updatedAt;
    final String name;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"] == null ? null : json["email"],
        v: json["__v"] == null ? null : json["__v"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "email": email == null ? null : email,
        "__v": v == null ? null : v,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "name": name == null ? null : name,
    };
}
