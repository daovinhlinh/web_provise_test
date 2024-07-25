import 'package:flutter/material.dart';
import 'package:web_provise_test/assets.dart';
import 'package:web_provise_test/src/models/recipe.dart';
import 'package:web_provise_test/src/widgets/network_image_with_fallback.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: isLandscape
          ? const EdgeInsets.only(bottom: 8)
          : const EdgeInsets.only(right: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: isLandscape
          ? _buildLandscapeLayout(context)
          : _buildPortraitLayout(context),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: _buildThumbImage(context, true),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(),
              const SizedBox(
                height: 2,
              ),
              _buildHeadline(),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Text("Difficulty",
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey, height: 1.2)),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.star,
                    size: 16,
                    color: Colors.amber,
                  ),
                  Text(recipe.difficulty.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              _buildTimeAndCalories()
            ],
          ),
        )
      ],
    );
  }

  Row _buildPortraitLayout(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildThumbImage(context, false)),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(
                  height: 2,
                ),
                _buildHeadline(),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text("Difficulty",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey, height: 1.2)),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    Text(recipe.difficulty.toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                _buildTimeAndCalories()
              ],
            ),
          ),
        )
      ],
    );
  }

  SizedBox _buildHeadline() {
    return SizedBox(
      height: 12 * 1.2 * 2,
      child: Text(
        recipe.headline ?? "",
        maxLines: 2,
        style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.2),
      ),
    );
  }

  SizedBox _buildTitle() {
    return SizedBox(
      height: 16 * 1.2 * 2,
      child: Text(
        recipe.name ?? "",
        maxLines: 2,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
    );
  }

  Row _buildTimeAndCalories() {
    return Row(
      children: [
        _iconText(Icons.access_time, recipe.time ?? ""),
        const SizedBox(
          width: 10,
        ),
        _iconText(Icons.local_fire_department, recipe.calories ?? ""),
      ],
    );
  }

  Widget _buildThumbImage(BuildContext context, bool isLandscape) {
    final width = MediaQuery.of(context).size.width;

    return NetworkImageWithFallback(
      imageUrl: recipe.thumb,
      fallbackAsset: Asset.imgRecipeThumbPlaceholder,
      width: isLandscape ? width * 0.4 : width * 0.35,
      height: isLandscape ? null : width,
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(
          width: 4,
        ),
        Text(text,
            style: const TextStyle(
              fontSize: 12,
            )),
      ],
    );
  }
}
