import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.only(left: 10, right: 10),
        children: [DemoWidget(context), DemoWidget(context)],
      ),
    ));
  }

  Widget DemoWidget(BuildContext context) {
    final theme = Theme.of(context);
    final ts = theme.textTheme;
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(30))),
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Image.network(
                width: 400,
                height: 200,
                fit: BoxFit.cover,
                'https://static.vecteezy.com/system/resources/previews/036/499/568/non_2x/snack-mini-pizza-with-sausages-tomato-and-cheese-on-a-wooden-board-top-and-vertical-view-photo.jpg'),
          ),
          10.ht,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndInfo(Icons.timer_sharp, '30 min'),
              IconAndInfo(Icons.local_fire_department_outlined, '200 cal'),
              IconAndInfo(Icons.dinner_dining, '1 serving'),
            ],
          ),
          10.ht,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  """Aloo Tikki """,
                  style: ts.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              //IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to Favourites')));
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              )
            ],
          ),
          5.ht,
          // 20.ht,
          // SizedBox(
          //     height: 50,
          //     width: double.infinity,
          //     child: OutlinedButton(
          //         onPressed: () {}, child: Text('Start Cooking..')))
        ]));
  }

  Widget IconAndInfo(IconData icon, String text) {
    return Builder(builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.orange,
            ),
            Text(text)
          ],
        ),
      );
    });
  }
}
