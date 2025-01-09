import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/routes/auto_route_setup.gr.dart';

@RoutePage()
class EntryPointPage extends StatelessWidget {
  const EntryPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      //  homeIndex: 0,
      routes: const [
        HomeRoute(),
        HomeNRoute2(),
        OfflineShowRoute(),
        ProfileRoute()
      ],
      bottomNavigationBuilder: (context, _) {
        final tabsRouter = context.tabsRouter;
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home-n',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_done),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
