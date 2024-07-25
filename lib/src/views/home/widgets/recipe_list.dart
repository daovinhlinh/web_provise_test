import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_provise_test/src/apis/recipe/recipe_api_impl.dart';
import 'package:web_provise_test/src/models/recipe.dart';
import 'package:web_provise_test/src/views/home/widgets/recipe_card.dart';
import 'package:web_provise_test/src/views/home/widgets/recipe_detail.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final RecipeApiImpl _recipeApi = RecipeApiImpl();
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
      await Future.delayed(const Duration(seconds: 2));

      // throw error to test error handling
      // throw Exception('An error occurred while loading the data');

      List<dynamic> data = await _recipeApi.getRecipes();

      if (data.isNotEmpty) {
        setState(() {
          isLoading = false;
          recipes = data.map((recipe) => Recipe.fromJson(recipe)).toList();
        });
      } else {
        setState(() {
          isLoading = false;
          recipes = [];
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
    return _buildContent();
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

  Widget _buildLoadedList() {
    return RefreshIndicator(
      onRefresh: fetchData,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.width * 0.35
                    : MediaQuery.of(context).size.height * 0.75,
                crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16),
            itemCount: recipes.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      useSafeArea: true,
                      constraints:
                          const BoxConstraints(maxWidth: double.infinity),
                      context: context,
                      enableDrag: true,
                      clipBehavior: Clip.hardEdge,
                      builder: (context) {
                        return Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          child: RecipeDetail(recipe: recipes[index]),
                        );
                      });
                },
                child: RecipeCard(
                  recipe: recipes[index],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingList() {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.landscape
              ? 3
              : 1, // Change this to control the number of items per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.35
              : MediaQuery.of(context).size.height * 0.75,
        ),
        itemBuilder: (context, index) {
          return orientation == Orientation.landscape
              ? _loadingItemLandscape(context)
              : _loadingItemPortrait(context);
        },
      );
    });
  }

  Widget _loadingItemLandscape(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16 * 1.2,
                  color: Colors.white,
                ),
                const SizedBox(height: 18.0),
                Container(
                  width: double.infinity,
                  height: 12 * 1.2 * 2,
                  color: Colors.white,
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: 100,
                  height: 16.0,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loadingItemPortrait(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
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
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
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
                          height: 16 * 1.2,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 18.0),
                        Container(
                          width: double.infinity,
                          height: 12 * 1.2 * 2,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          width: 100,
                          height: 16.0,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 4,
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
