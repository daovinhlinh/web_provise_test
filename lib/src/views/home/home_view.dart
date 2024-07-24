import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_provise_test/src/apis/recipe_api.dart';
import 'package:web_provise_test/src/models/recipe.dart';
import 'package:web_provise_test/src/views/home/widgets/custom_app_bar.dart';
import 'package:web_provise_test/src/views/home/widgets/recipe_card.dart';
import 'package:web_provise_test/src/views/home/widgets/recipe_detail.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RecipeApi _recipeApi = RecipeApi();
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      // sleep for 1 seconds to simulate a network request
      await Future.delayed(const Duration(seconds: 1));

      // throw error to test error handling
      // throw Exception('An error occurred while loading the data');

      List<dynamic> data = await _recipeApi.loadRecipes();

      if (data.isNotEmpty) {
        setState(() {
          isLoading = false;
          recipes = data.map((recipe) => Recipe.fromJson(recipe)).toList();
        });
      }
    } catch (e) {
      // Run after widget has been rendered and built
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('An error occurred while loading the data: $e'),
                  backgroundColor: Colors.red,
                ),
              ));
      setState(() {
        isLoading = false;
        recipes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: fetchData,
          child: _buildContent(),
        )));
  }

  Widget _buildContent() {
    if (isLoading) {
      return _buildLoadingList();
    } else if (recipes.isNotEmpty) {
      return _buildLoadedList();
    } else {
      return _buildEmptyList();
    }
  }

  Center _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text('No recipes found', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: fetchData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  ListView _buildLoadedList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                useSafeArea: true,
                context: context,
                enableDrag: true,
                clipBehavior: Clip.hardEdge,
                builder: (context) {
                  return (Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: RecipeDetail(recipe: recipes[index]),
                  ));
                });
          },
          child: RecipeCard(
            recipe: recipes[index],
          ),
        );
      },
      itemCount: recipes.length,
    );
  }

  ListView _buildLoadingList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          height: 14.0,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: 100,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
