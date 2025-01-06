import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/extensions/riverpod_builder.dart';
import 'package:recipe_app/features/present_recipe/presentation/riverpod/offline_recipe_display_rp.dart';

@RoutePage()
class OfflineShowPage extends StatelessWidget {
  const OfflineShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiverpodBuilder(builder: (ctx, ref) {
        final recipes = ref.watch(offlineRecipeProvider);
        return recipes.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].name),
                    subtitle: Text(data[index].cuisine),
                  );
                },
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (e, s) {
              return Text('Error: $e');
            });
      }),
    );
  }
}
