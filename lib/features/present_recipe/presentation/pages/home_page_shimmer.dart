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
          IconButton(
              icon: Badge(
                child: Icon(Icons.notifications),
                label: Text('3'),
              ),
              onPressed: () {}),
          PopupMenuButton(itemBuilder: (context) => []),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ht,
                _buildTaglineShimmer(),
                20.ht,
                _buildCategoryShimmer(),
                30.ht,
                _buildInfoTipShimmer(),
                30.ht,
                _buildHorizontalListShimmer(title: 'For You'),
                30.ht,
                _buildHorizontalListShimmer(title: 'Popular Recipes'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaglineShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.maxFinite,
        height: 12,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: Duration(minutes: 12),
      child: Wrap(
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
    );
  }

  Widget _buildInfoTipShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.maxFinite,
        height: 12,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHorizontalListShimmer({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 100,
            height: 20,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade300,
                enabled: false,
                child: Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                      ),
                      10.ht,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 80, height: 12, color: Colors.white),
                          5.ht,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 60, height: 12, color: Colors.white),
                              Container(
                                  width: 40, height: 12, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
