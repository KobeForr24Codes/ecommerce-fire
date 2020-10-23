import 'package:ecommerce_fire/models/user.dart';
import 'package:ecommerce_fire/tabs/home_tab.dart';
import 'package:ecommerce_fire/tabs/saved_tab.dart';
import 'package:ecommerce_fire/tabs/search_tab.dart';
import 'package:ecommerce_fire/widgets/bottom_tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (value) {
                setState(() {
                  _selectedTab = value;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(userId: user.uid),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (value) {
              setState(() {
                _tabsPageController.animateToPage(
                  value,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                );
              });
            },
          )
        ],
      ),
    );
  }
}
