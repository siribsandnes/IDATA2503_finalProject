import 'package:flutter/material.dart';

//Represents a main drawer. Does not have to be statefull as we will "Manage state" with Navigator
class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    //required this.onSelectScreen,
  });

  //final Function(String identifier) onSelectScreen;

  //Builds a drawer which is a "menu" that pops out from side of screen when clicked
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(1000, 44, 88, 200),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 60, 5, 60),
        child: Column(
          children: [
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'Home',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('meals');
              },
            ),
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.person_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'My profile',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('filters');
              },
            ),
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.history_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'History',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('filters');
              },
            ),
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('filters');
              },
            ),
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.query_stats_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'Statistics',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('filters');
              },
            ),
            //Element in the menu drawer that pops out
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                size: 26,
                color: Colors.white,
              ),
              title: Text(
                'Log out',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              onTap: () {
                //onSelectScreen('filters');
              },
            ),
          ],
        ),
      ),
    );
  }
}
