import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/on_num.dart';

import '../../../../routes/auto_route_setup.gr.dart';
import '../riverpod/search_recipe_rp.dart';

@RoutePage()
class SearchRecipePage extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext, ref) {
    final searchProvider = ref.watch(searchRecipeRpProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Recipe'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onSubmitted: (value) {
                  ref
                      .read(searchRecipeRpProvider.notifier)
                      .searchRecipes(value);
                },
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Recipe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      final text = _searchController.text;
                      ref
                          .read(searchRecipeRpProvider.notifier)
                          .searchRecipes(text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
                onChanged: (value) {},
              ),
              20.ht,
              searchProvider.when(
                  data: (data) {
                    if (data.data == null)
                      return Text("Enter your favorite recipe name to search");
                    final mydata = data.data!;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: mydata.recipes.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                context.pushRoute(RecipeDetailRoute(
                                    recipe: mydata.recipes[index]));
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                      child: CircularProgressIndicator());
                                }, height: 50, mydata.recipes[index].image),
                              ),
                              title: Text(mydata.recipes[index].name),
                              subtitle: Text(mydata.recipes[index].cuisine),
                            );
                          }),
                    );
                  },
                  error: (e, s) => Text(e.toString()),
                  loading: () => Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()))
            ],
          ),
        ));
  }
}
