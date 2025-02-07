// To parse this JSON data, do
//
//     final ramShalakaModal = ramShalakaModalFromJson(jsonString);

import 'dart:convert';

RamShalakaModal ramShalakaModalFromJson(String str) => RamShalakaModal.fromJson(json.decode(str));

String ramShalakaModalToJson(RamShalakaModal data) => json.encode(data.toJson());

class RamShalakaModal {
  int status;
  List<Datum> data;

  RamShalakaModal({
    required this.status,
    required this.data,
  });

  factory RamShalakaModal.fromJson(Map<String, dynamic> json) => RamShalakaModal(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

// ram
class Datum {
  int id;
  String letter;
  String chaupai;
  String description;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String hiDescription;
  List<dynamic> translations;

  Datum({
    required this.id,
    required this.letter,
    required this.chaupai,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.hiDescription,
    required this.translations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    letter: json["letter"],
    chaupai: json["chaupai"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    hiDescription: json["hi_description"],
    translations: List<dynamic>.from(json["translations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "letter": letter,
    "chaupai": chaupai,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "hi_description": hiDescription,
    "translations": List<dynamic>.from(translations.map((x) => x)),
  };
}// TODO Implement this library.