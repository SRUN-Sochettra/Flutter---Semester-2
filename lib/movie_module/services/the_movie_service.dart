import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api_key.dart';
import '../models/movie_detail_model.dart';
import '../models/the_movie_model.dart';

class TheMovieService {
  final baseUrl = "https://api.themoviedb.org/3/movie";

  static final Map<String, TheMovie> _nowPlayingCache = {};
  static final Map<String, MovieDetail> _movieDetailCache = {};

  Future<TheMovie> read({bool forceRefreshed = false}) async {
    const cacheKey = "now_playing";
    if (forceRefreshed) {
      _nowPlayingCache.clear();
    }
    if (_nowPlayingCache.containsKey(cacheKey)) {
      return Future.value(_nowPlayingCache[cacheKey]!);
    }

    try {
      http.Response response = await http.get(
        Uri.parse("$baseUrl/now_playing?language=en-US&page=1&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        final TheMovie data = await compute(theMovieFromJson, response.body);
        _nowPlayingCache[cacheKey] = data;
        return data;
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieDetail> get(String movieId, {bool forceRefreshed = false}) async {
    if (forceRefreshed) {
      _movieDetailCache.clear();
    }
    if (_movieDetailCache.containsKey(movieId)) {
      return Future.value(_movieDetailCache[movieId]!);
    }

    try {
      http.Response response = await http.get(
        Uri.parse("$baseUrl/$movieId?language=en-US&api_key=$apiKey"),
      );
      if (response.statusCode == 200) {
        final MovieDetail detail = await compute(movieDetailFromJson, response.body);
        _movieDetailCache[movieId] = detail;
        return detail;
      } else {
        throw Exception("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
