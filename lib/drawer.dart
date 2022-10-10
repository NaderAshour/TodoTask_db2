

import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://scontent.faly8-2.fna.fbcdn.net/v/t39.30808-6/217946012_2909788445931365_185904278134005682_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=D-vfFrMu_fMAX-uOyea&_nc_ht=scontent.faly8-2.fna&oh=00_AT-j40cQG0KkOu86N83E6p1_wGOcuC5h9DyEEjnDNNwIcw&oe=6344E2D9'),
              ),
              accountName: Text('Nader'),
              accountEmail: Text('naderashour19@gmail\.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}