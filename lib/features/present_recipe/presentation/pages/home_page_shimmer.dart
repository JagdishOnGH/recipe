import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class RecipeShimmerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          PopupMenuButton(itemBuilder: (context) => []),
        ],
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.ht,
              // Tagline
              Container(
                width: double.maxFinite,
                height: 10,
                color: Colors.white,
              ),
              20.ht,
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              30.ht,

              // Info Tip
              Container(
                width: double.maxFinite,
                height: 10,
                color: Colors.red,
              ),
              30.ht,

              // "For You" Section
              Text('For You',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 100,
                                    height: 12,
                                    color: Colors.white),
                                SizedBox(height: 4),
                                Container(
                                    width: 60, height: 12, color: Colors.white),
                                SizedBox(height: 4),
                                Container(
                                    width: 40, height: 12, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              30.ht,

              // "Popular Recipes" Section
              Text('Popular Recipes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 100,
                                    height: 12,
                                    color: Colors.white),
                                SizedBox(height: 4),
                                Container(
                                    width: 60, height: 12, color: Colors.white),
                                SizedBox(height: 4),
                                Container(
                                    width: 40, height: 12, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
