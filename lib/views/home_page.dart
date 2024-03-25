import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/views/article_list_page.dart';
import 'package:news_app/views/settings_page.dart';
import 'package:news_app/widgets/platform_widget.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  static const routeName = '/home_page';

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: 'Headline'
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: 'Settings'
    )
  ];

  final List<Widget> _listWidget = [
    ArticleListPage(),
    SettingsPage()
  ];

  int _bottomNavIndex = 0;

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
    body: _listWidget[_bottomNavIndex],
    bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: secondaryColor,
      currentIndex: _bottomNavIndex,
      items: _bottomNavBarItems,
      onTap: (selected) {
        setState(() {
          _bottomNavIndex = selected;
        });
      },
      ),
  );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavBarItems
      ), 
      tabBuilder: (context, index){
        return _listWidget[index];
      });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid, 
      iosBuilder: _buildIos);
  }
}