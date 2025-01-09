import 'package:flutter/material.dart';

class SuggestedCuisineComp extends StatelessWidget {
  final List<String> suggestedCuisine;

  SuggestedCuisineComp({super.key, required this.suggestedCuisine}) {
    if (suggestedCuisine.length > 4)
      assert(suggestedCuisine.length > 4,
          "Suggested Cuisine should not be more than 4 items");
  }

  //blue green yellow purple human eye friendly color, also it will have black text
  final List<Color> colors = <Color>[
    Colors.blue.withValues(alpha: 0.9),
    Colors.green.withValues(alpha: 0.9),
    Colors.yellow.withValues(alpha: 0.9),
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    final ts = Theme.of(context).textTheme;
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: suggestedCuisine.map((e) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: colors[suggestedCuisine.indexOf(e)],
              borderRadius: BorderRadius.circular(10)),
          height: 60,
          width: 180,
          child: Text(
            "$e",
            style: ts.titleMedium,
          ),
        );
      }).toList(),
    );
  }
}
