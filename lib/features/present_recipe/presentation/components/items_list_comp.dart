import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

class ItemsComp extends StatelessWidget {
  const ItemsComp({super.key});

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(8),
        height: 230,
        width: 175,
        decoration: BoxDecoration(
          color: Colors.amber.shade200.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://static.vecteezy.com/system/resources/previews/036/499/568/non_2x/snack-mini-pizza-with-sausages-tomato-and-cheese-on-a-wooden-board-top-and-vertical-view-photo.jpg",
                  cacheKey: "recipe-image-1",
                ),
              ),
            ),
            10.ht,
            Text(
              "Aloo Bhujiya",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: ts.titleSmall,
            ),
            5.ht,
            Row(
              spacing: 20,
              children: [
                Expanded(
                  child: Text(
                    "Italian",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ts.bodyMedium,
                  ),
                ),
                Text(
                  "5 min",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ts.bodyMedium,
                ),
              ],
            ),
          ],
        ));
  }
}
