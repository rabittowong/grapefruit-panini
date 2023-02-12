import 'package:flutter/material.dart';

import '../model/profile_model.dart';
import '../page/expenditure/expenditure_content.dart';
import '../page/health/health_content.dart';
import 'expenditure/expenditure_create.dart';
import 'health/health_create.dart';
import 'household/household_content.dart';
import 'household/household_create.dart';
import 'laundry/laundry_content.dart';
import 'laundry/laundry_create.dart';
import 'profile/profile_content.dart';

class RouterContent extends StatefulWidget {
  const RouterContent({super.key, required this.profile});

  final ProfileModel profile;

  @override
  State<RouterContent> createState() => _RouterContentState();
}

class _RouterContentState extends State<RouterContent> {
  static const List<String> _pageWidgetTitles = [
    '家用',
    '消費記錄',
    '血壓記錄',
    '洗衣表',
  ];

  static const List<Widget> _pageWidgetOptions = [
    HouseholdContent(),
    ExpenditureContent(),
    HealthContent(),
    LaundryContent(),
  ];

  static const List<Widget> _createWidgetOptions = [
    HouseholdCreate(),
    ExpenditureCreate(),
    HealthCreate(),
    LaundryCreate(),
  ];

  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _getIconButton(IconData iconData, int index) {
    return IconButton(
      icon: Icon(iconData),
      color: Colors.black54,
      tooltip: _pageWidgetTitles.elementAt(index),
      onPressed: () {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageWidgetTitles.elementAt(_selectedIndex),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton(
            onSelected: (result) {
              if (result == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileContent(profile: widget.profile)));
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 0, child: Text('個人檔案')),
              ];
            },
          ),
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _pageWidgetOptions,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _getIconButton(Icons.home_rounded, 0),
            _getIconButton(Icons.attach_money_rounded, 1),
            const SizedBox(width: 40, height: 60),
            _getIconButton(Icons.bloodtype_rounded, 2),
            _getIconButton(Icons.sanitizer_rounded, 3),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      _createWidgetOptions.elementAt(_selectedIndex)));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
