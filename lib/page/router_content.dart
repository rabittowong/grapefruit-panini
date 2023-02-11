import 'package:flutter/material.dart';

import '../model/profile_model.dart';
import '../page/expenditure/expenditure_content.dart';
import '../page/health/health_content.dart';
import '../page/home/home_content.dart';
import '../page/laundry/laundry_content.dart';
import 'household/household_content.dart';

class RouterContent extends StatefulWidget {
  const RouterContent({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<RouterContent> createState() => _RouterContentState();
}

class _RouterContentState extends State<RouterContent> {
  int _selectedIndex = 3;

  static const _widgetOptions = [
    HomeContent(),
    HouseholdContent(),
    ExpenditureContent(),
    HealthContent(),
    LaundryContent(),
  ];
  static const _widgetTitles = [
    '柚子記事簿',
    '家用記錄',
    '我的消費記錄',
    '我的血壓記錄',
    '洗衣表',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _widgetTitles.elementAt(_selectedIndex),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded),
            label: '柚子記事簿',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '家用記錄',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded),
            label: '我的消費記錄',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_rounded),
            label: '我的血壓記錄',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sanitizer_rounded),
            label: '洗衣表',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
