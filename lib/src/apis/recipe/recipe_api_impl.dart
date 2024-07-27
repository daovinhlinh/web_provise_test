import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web_provise_test/assets.dart';
import 'package:web_provise_test/src/apis/recipe/recipe_api.dart';

Future<T> loadJson<T>(String uri) async {
//Load json
  String jsonString = await rootBundle.loadString(uri);
  // decode json
  return jsonDecode(jsonString);
}

class RecipeApiImpl implements RecipeApi {
  @override
  Future<List<dynamic>> getRecipes() async {
    return loadJson(Asset.jsonRecipes);
  }
}
