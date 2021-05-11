import 'dart:math';

import 'package:flutter/material.dart';

class SliverListDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: <Widget>[
              DrawerListItem('Item 1'),
              DrawerListItem('Item 2'),
              DrawerListItem('Item 3'),
              ExpansionTile(
                  leading: Icon(Icons.details),
                  title: Text('Expandable item'),
                  children: [
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                    DrawerListItem('Subitem'),
                  ]),
              DrawerListItem('Item 4'),
              Spacer(),
              DrawerListItem('Log out', color: Colors.red),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
          DrawerListItem("SliverChildListDelegate 1 ", icon: Icons.add),
        ])),
        SliverGrid(
            delegate: SliverChildListDelegate([
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
              DrawerGridItem(title: "SliverGrid"),
            ]),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
      ],
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const DrawerListItem(this.title, {this.color, this.icon = Icons.star});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
    );
  }
}

class DrawerGridItem extends StatelessWidget {
  final String title;
  final Color color =
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  DrawerGridItem({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      child: Center(
        child: Text(
          "$title",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
