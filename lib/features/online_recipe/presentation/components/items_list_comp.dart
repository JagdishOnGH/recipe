import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../models/recipe_model.dart';

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
    return Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(8),
        height: 85,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.amber.shade200.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  // useOldImageOnUrlChange: true,
                  imageUrl: recipe.image,
                  cacheKey: "recipe-image-${recipe.id}",
                ),
              ),
            ),
            10.ht,
            Text(recipe.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: ts.titleSmall?.copyWith(
                  color: theme.primaryColor,
                )),
            5.ht,
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Text(
                    recipe.cuisine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ts.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
