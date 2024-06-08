import 'dart:convert';
import 'package:egypttour/views/favourites_screen/data/favourites_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorage {
  static const _key = 'favorite_places';

  static Future<List<FavoritePlace>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList == null) {
      return [];
    }

    return jsonList.map((jsonString) {
      Map<String, dynamic> map = json.decode(jsonString);
      return FavoritePlace.fromJson(map);
    }).toList();
  }

  static Future<void> saveFavorites(List<FavoritePlace> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = favorites.map((favorite) {
      return json.encode(favorite.toJson());
    }).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<void> addFavorite(FavoritePlace favorite) async {
    List<FavoritePlace> favorites = await getFavorites();
    if (!favorites.any((fav) => fav.id == favorite.id)) {
      favorites.add(favorite);
      await saveFavorites(favorites);
    }
  }

  static Future<void> removeFavorite(String id) async {
    List<FavoritePlace> favorites = await getFavorites();
    favorites.removeWhere((fav) => fav.id == id);
    await saveFavorites(favorites);
  }
}
