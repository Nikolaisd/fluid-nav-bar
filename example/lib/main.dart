import 'package:example/content/home.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'content/account.dart';
import 'content/grid.dart';

void main() => runApp(FluidNavBarDemo());

class FluidNavBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _FluidNavBarDemoState();
  }
}

class _FluidNavBarDemoState extends State {
  Widget? _child;

  @override
  void initState() {
    _child = HomeContent();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF75B7E1),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                svgPath: "assets/home.svg",
                unselectedBackgroundColor: Color(0xFF4285F4),
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.bookmark_border,
                unselectedBackgroundColor: Color.fromARGB(255, 255, 1, 1),
                extras: {"label": "bookmark"}),
            FluidNavBarIcon(
                icon: Icons.home_filled,
                unselectedBackgroundColor: Color.fromARGB(255, 255, 1, 1),
                selectedIcon: Icons.add,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.apps,
                unselectedBackgroundColor: Color(0xFFFCBA02),
                extras: {"label": "partner"}),
            FluidNavBarIcon(
                svgPath: "assets/conference.svg",
                unselectedBackgroundColor: Color(0xFF34A950),
                extras: {"label": "conference"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
            iconUnselectedForegroundColor: Colors.white,
            linearGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFA000), Color(0xFFF57C00)]),
          ),
          scaleFactor: 1.5,
          defaultIndex: 1,
          iconSizeFactor: 0.8,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeContent();
          break;
        case 1:
          _child = AccountContent();
          break;
        case 2:
          _child = GridContent();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
