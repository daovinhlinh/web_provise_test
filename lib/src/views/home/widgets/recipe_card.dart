import 'package:flutter/material.dart';
import 'package:web_provise_test/src/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: const EdgeInsets.only(right: 4),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              recipe.thumb!,
              width: MediaQuery.of(context).size.width * 0.32,
              height: MediaQuery.of(context).size.width * 0.32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    recipe.headline!,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey, height: 1.2),
                  ),
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
                  Row(
                    children: [
                      _iconText(Icons.access_time, recipe.time!),
                      const SizedBox(
                        width: 10,
                      ),
                      _iconText(Icons.local_fire_department, recipe.calories!),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(
          width: 5,
        ),
        Text(text,
            style: const TextStyle(
              fontSize: 12,
            )),
      ],
    );
  }
}
