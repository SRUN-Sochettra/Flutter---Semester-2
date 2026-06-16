import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api_key.dart';
import '../models/person_model.dart';

class ThePeopleService {
  final baseUrl = "https://api.themoviedb.org/3/person";

  static final Map<String, PopularPeople> _popularPeopleCache = {};
  static final Map<String, PersonDetail> _personDetailCache = {};

  Future<PopularPeople> readPopular({bool forceRefreshed = false}) async {
    const cacheKey = "popular";
    if (forceRefreshed) {
      _popularPeopleCache.clear();
    }
    if (_popularPeopleCache.containsKey(cacheKey)) {
      return Future.value(_popularPeopleCache[cacheKey]!);
    }

    try {
      http.Response response = await http.get(
        Uri.parse("$baseUrl/popular?language=en-US&page=1&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        final PopularPeople data = await compute(popularPeopleFromJson, response.body);
        _popularPeopleCache[cacheKey] = data;
        return data;
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PersonDetail> get(String personId, {bool forceRefreshed = false}) async {
    if (forceRefreshed) {
      _personDetailCache.clear();
    }
    if (_personDetailCache.containsKey(personId)) {
      return Future.value(_personDetailCache[personId]!);
    }

    try {
      http.Response response = await http.get(
        Uri.parse("$baseUrl/$personId?language=en-US&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        final PersonDetail detail = await compute(personDetailFromJson, response.body);
        _personDetailCache[personId] = detail;
        return detail;
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
