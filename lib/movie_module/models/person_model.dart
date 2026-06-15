// To parse this JSON data, do
//
//     final popularPeople = popularPeopleFromJson(jsonString);

import 'dart:convert';

PopularPeople popularPeopleFromJson(String str) =>
    PopularPeople.fromJson(json.decode(str));

String popularPeopleToJson(PopularPeople data) => json.encode(data.toJson());

class PopularPeople {
  int page;
  List<Person> results;
  int totalPages;
  int totalResults;

  PopularPeople({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularPeople.fromJson(Map<String, dynamic> json) => PopularPeople(
    page: json["page"],
    results: List<Person>.from(json["results"].map((x) => Person.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Person {
  int id;
  String name;
  String? profilePath;
  double? popularity;
  String? knownForDepartment;

  Person({
    required this.id,
    required this.name,
    this.profilePath,
    this.popularity,
    this.knownForDepartment,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"],
    name: json["name"],
    profilePath: json["profile_path"],
    popularity: json["popularity"]?.toDouble(),
    knownForDepartment: json["known_for_department"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_path": profilePath,
    "popularity": popularity,
    "known_for_department": knownForDepartment,
  };
}

// Person detail
PersonDetail personDetailFromJson(String str) =>
    PersonDetail.fromJson(json.decode(str));

String personDetailToJson(PersonDetail data) => json.encode(data.toJson());

class PersonDetail {
  int id;
  String name;
  String? biography;
  String? birthday;
  String? placeOfBirth;
  String? profilePath;
  List<String> alsoKnownAs;

  PersonDetail({
    required this.id,
    required this.name,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.profilePath,
    required this.alsoKnownAs,
  });

  factory PersonDetail.fromJson(Map<String, dynamic> json) => PersonDetail(
    id: json["id"],
    name: json["name"],
    biography: json["biography"],
    birthday: json["birthday"],
    placeOfBirth: json["place_of_birth"],
    profilePath: json["profile_path"],
    alsoKnownAs: json["also_known_as"] == null
        ? []
        : List<String>.from(json["also_known_as"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "biography": biography,
    "birthday": birthday,
    "place_of_birth": placeOfBirth,
    "profile_path": profilePath,
    "also_known_as": List<dynamic>.from(alsoKnownAs.map((x) => x)),
  };
}
