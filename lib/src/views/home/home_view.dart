import 'package:flutter/material.dart';
import 'package:web_provise_test/src/views/home/widgets/custom_app_bar.dart';
import 'package:web_provise_test/src/views/home/widgets/recipe_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: "Recipe"),
        body: const SafeArea(child: RecipeList()));
  }
}
