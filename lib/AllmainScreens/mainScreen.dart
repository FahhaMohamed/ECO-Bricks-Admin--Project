
import 'package:eco_bricks/AllmainScreens/soldScreen.dart';
import 'package:flutter/material.dart';

import 'addScreen.dart';
import 'homeScreen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> with SingleTickerProviderStateMixin{

  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index)
  {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {

    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          homeScreen(),
          addScreen(),
          soldScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          iconSize: 25,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Add'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.sell),
                label: 'Sold'
            ),
          ],
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.purple,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemClicked,
        ),
      )
    );
  }
}
