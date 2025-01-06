import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/riverpod_builder.dart';
import 'package:recipe_app/features/present_recipe/presentation/riverpod/offline_recipe_display_rp.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../comps/offline_items_comp.dart';

@RoutePage()
class OfflineShowPage extends StatelessWidget {
  const OfflineShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Recipes'),
        actions: [
          IconButton(
            onPressed: () async {
              final informationDialogue = AlertDialog(
                title: Text('Offline Recipes'),
                content: Text(
                    'This page shows the recipes that you have saved offline. You can save a recipe offline by clicking on the download icon on the recipe detail page.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
              await showDialog(
                context: context,
                builder: (context) => informationDialogue,
              );
            },
            icon: Icon(Icons.help),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RiverpodBuilder(builder: (ctx, ref) {
              final recipes = ref.watch(offlineRecipeProvider);
              return recipes.when(
                  data: (data) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final recipe = data[index];
                        return InkWell(
                          child: OfflineItemsComp(recipe: recipe),
                          onTap: () {
                            context
                                .pushRoute(RecipeDetailRoute(recipe: recipe));
                          },
                        );
                      },
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (e, s) {
                    return Text('Error: $e');
                  });
            }),
          ),
        ],
      ),
    );
  }
}
