import 'dart:convert';

import 'package:flutter/services.dart';

Future<T> loadJson<T>(String uri) async {
//Load json
  String jsonString = await rootBundle.loadString(uri);
  // decode json
  return jsonDecode(jsonString);
}

class RecipeApi {
  Future<List<dynamic>> loadRecipes() async {
    return loadJson('assets/recipes.json');
  }
}
