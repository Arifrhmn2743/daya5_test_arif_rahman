// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

MovieModel movieModelFromJson(String str) =>
    MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  String status;
  List<Datum> data;
  dynamic info;

  MovieModel({
    required this.status,
    required this.data,
    this.info,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        info: json["info"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "info": info,
      };
}

class Datum {
  int id;
  String title;
  String description;
  String poster;
  DateTime createdDate;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.poster,
    required this.createdDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        poster: json["poster"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "poster": poster,
        "created_date": createdDate.toIso8601String(),
      };
}
