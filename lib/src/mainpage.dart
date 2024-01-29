import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person_2_square_stack_fill),
            icon: Icon(CupertinoIcons.person_2_square_stack),
            label: 'Absensi',
          ),
          NavigationDestination(
            selectedIcon: Icon(CupertinoIcons.person_alt_circle_fill),
            icon: Icon(CupertinoIcons.person_alt_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Label behavior: ${labelBehavior.name}'),
            const SizedBox(height: 10),
            OverflowBar(
              spacing: 10.0,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      labelBehavior =
                          NavigationDestinationLabelBehavior.alwaysShow;
                    });
                  },
                  child: const Text('alwaysShow'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      labelBehavior =
                          NavigationDestinationLabelBehavior.alwaysHide;
                    });
                  },
                  child: const Text('alwaysHide'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Material(
        shape: const CircleBorder(),
        color: Colors
            .green.shade400, // container color,to have splash color effect
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: Colors.white10.withOpacity(0.1),
          onTap: () {},
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              //         shape: BoxShape.circle,
              shape: BoxShape.circle,
              color: Colors.transparent, // material color will cover this
            ),
            child: const Icon(
              CupertinoIcons.qrcode,
              size: 35,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
