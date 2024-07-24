import 'package:flutter/material.dart';
import 'package:web_provise_test/src/models/recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecipeThumb(context),
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      _buildHeader(),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildDiffAndTime(),
                      _buildRecipeNutrition(),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildDescription(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 20,
          left: 20,
          child: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.arrow_back,
                    color: Colors.black, size: 24)),
          ),
        ),
      ],
    );
  }

  Row _buildDiffAndTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              const Text("Difficulty:",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(recipe.difficulty.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              const Text("Time:",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(
                width: 4,
              ),
              Text(recipe.time.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.name!,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
        ),
        Text(
          recipe.headline!,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 4,
        ),
        Text(
          recipe.description!,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Image _buildRecipeThumb(BuildContext context) {
    return Image.network(recipe.image!,
        height: MediaQuery.of(context).size.height * 0.4,
        fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      }
      return Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.4,
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      );
    });
  }

  Widget _buildRecipeNutrition() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(children: [
                const Text(
                  "Calories: ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(recipe.calories ?? '--',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ]),
            ),
            Expanded(
              child: Row(children: [
                const Text(
                  "Carbos: ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(recipe.carbos!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ]),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(children: [
                const Text(
                  "Fats: ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(recipe.fats!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ]),
            ),
            Expanded(
              child: Row(children: [
                const Text(
                  "Proteins: ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(recipe.proteins!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
