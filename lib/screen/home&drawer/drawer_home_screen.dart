import 'package:flutter/material.dart';

import 'package:food_app/screen/home&drawer/drawer_screen.dart';
import 'package:food_app/screen/home_screen.dart';

class DrawerHomeScreen extends StatefulWidget {
  const DrawerHomeScreen({Key key}) : super(key: key);
  static const routeName = 'home-drawer-screen';

  @override
  _DrawerHomeScreenState createState() => _DrawerHomeScreenState();
}

class _DrawerHomeScreenState extends State<DrawerHomeScreen> {
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scalefactor = 0.0;
  bool isDragging = false;
  bool isDrawerOpen;
  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  void openDrawer() {
    setState(() {
      xOffset = 260;
      yOffset = 120;
      scalefactor = 0.7;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scalefactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildDrawer() {
      return SafeArea(
          child: DrawerScreen(
        closeDrawer: closeDrawer,
      ));
    }

    Widget buildHome() {
      return WillPopScope(
        onWillPop: () async {
          if (isDrawerOpen) {
            closeDrawer();
            return false;
          } else {
            return true;
          }
        },
        child: GestureDetector(
          onTap: closeDrawer,
          onHorizontalDragStart: (details) {
            if (!isDragging) return;

            isDragging = true;
          },
          onHorizontalDragUpdate: (details) {
            const delta = 1;
            if (details.delta.dx > delta) {
              openDrawer();
            } else if (details.delta.dx < -delta) {
              closeDrawer();
            }
            isDragging = false;
          },
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 450),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scalefactor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen ? 45 : 0),
                child: Container(
                  color: isDrawerOpen ? Colors.transparent : Colors.white,
                  child: AbsorbPointer(
                    absorbing: isDrawerOpen,
                    child: HomeScreen(
                      openDrawer: openDrawer,
                    ),
                  ),
                ),
              )),
        ),
      );
    }

    Widget buildHometwo() {
      return WillPopScope(
        onWillPop: () async {
          if (isDrawerOpen) {
            closeDrawer();
            return false;
          } else {
            return true;
          }
        },
        child: GestureDetector(
          onTap: closeDrawer,
          onHorizontalDragStart: (details) {
            if (!isDragging) return;

            isDragging = true;
          },
          onHorizontalDragUpdate: (details) {
            const delta = 1;
            if (details.delta.dx > delta) {
              openDrawer();
            } else if (details.delta.dx < -delta) {
              closeDrawer();
            }
            isDragging = false;
          },
          child: Opacity(
            opacity: 0.3,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                transform: Matrix4.translationValues(230, 160, 0)..scale(0.6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isDrawerOpen ? 45 : 0),
                  child: Container(
                    color: isDrawerOpen ? Colors.transparent : Colors.white,
                    child: AbsorbPointer(
                      absorbing: isDrawerOpen,
                      child: HomeScreen(
                        openDrawer: openDrawer,
                      ),
                    ),
                  ),
                )),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          buildDrawer(),
          // isDrawerOpen ? buildHometwo() : Container(),
          buildHometwo(),
          buildHome(),
        ],
      ),
    );
  }
}
