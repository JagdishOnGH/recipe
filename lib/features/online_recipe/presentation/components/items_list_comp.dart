import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../../models/recipe_model.dart';

class ItemsGridComp extends StatelessWidget {
  final Recipe recipe;

  const ItemsGridComp(
    this.recipe, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.4; // 40% of screen width
    final imageHeight = itemWidth * 0.5; // Maintain aspect ratio

    return InkWell(
      onTap: () {
        context.router.push(RecipeDetailRoute(recipe: recipe));
      },
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.02),
        // 2% of screen width

        padding: EdgeInsets.all(8),
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colors.amber.shade200.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: recipe.image,
                cacheKey: "recipe-image-${recipe.id}",
                height: imageHeight,
                width: double.infinity,
              ),
            ),
            10.ht,
            Text(
              recipe.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ts.titleSmall?.copyWith(color: theme.primaryColor),
            ),
            5.ht,
            Text(
              recipe.cuisine,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ts.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemsComp extends StatelessWidget {
  final Recipe recipe;

  const ItemsComp(
    this.recipe, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth * 0.4; // 40% of screen width
    final imageHeight = itemWidth * 0.6; // Maintain aspect ratio

    return InkWell(
      onTap: () {
        context.router.push(RecipeDetailRoute(recipe: recipe));
      },
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.02),
        padding: EdgeInsets.all(8),
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colors.amber.shade200.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: recipe.image,
                cacheKey: "recipe-image-${recipe.id}",
                height: imageHeight,
                width: double.infinity,
              ),
            ),
            10.ht,
            Text(
              recipe.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ts.titleSmall?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            5.ht,
            Text(
              recipe.cuisine,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: ts.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
