import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../models/recipe_model.dart';

class OfflineItemsComp extends StatelessWidget {
  final Recipe recipe;

  const OfflineItemsComp({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        height: 200,
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "${recipe.image}",
                cacheKey: "recipe-image-${recipe.id}",
              ),
            ),
            10.ht,
            Text(
              "${recipe.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ts.titleSmall,
            ),
            5.ht,
            Text(
              "${recipe.cuisine}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ts.bodyMedium,
            ),
          ],
        ));
  }
}
