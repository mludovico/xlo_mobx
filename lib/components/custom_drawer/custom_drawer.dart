import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/widgets/header_section.dart';
import 'package:xlo_mobx/components/custom_drawer/widgets/page_section.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(50)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: Drawer(
            elevation: 0,
            child: ListView(
              children: [
                HeaderSection(),
                PageSection(),
                Divider(),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
