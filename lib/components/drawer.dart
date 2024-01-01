import 'package:flutter/material.dart';
import 'package:note_app/components/drawer_tile.dart';
import 'package:note_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  //This is the drawer widget
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //Drawer header
          const DrawerHeader(
            child: Icon(Icons.notes),
          ),
          //Notes tile
          DrawerTile(
            title: "Notes",
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          //settings tile
          DrawerTile(
            title: "Settings",
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
