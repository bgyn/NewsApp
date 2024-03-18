import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/core/constants/title_constant.dart';
import 'package:news_app/feature/bookmark/screen/bookmark_screen.dart';
import 'package:news_app/feature/explore/screen/explore_screen.dart';
import 'package:news_app/feature/home/screen/home_screen.dart';
import 'package:news_app/feature/profile/screen/profile_screen.dart';
import 'package:news_app/theme/custom_theme.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  static const List _screenOptions = [
    HomeScreen(),
    ExploreScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];
  static final List<String> _title = TitleContant().title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: _selectedIndex == 3,
        title: _selectedIndex != 0
            ? _selectedIndex == 3
                ? Text(
                    _title[_selectedIndex],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                : Text(
                    _title[_selectedIndex],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
                  )
            : Image.asset(
                _title[_selectedIndex],
                width: 100,
              ),
        actions: [
          _selectedIndex == 0
              ? InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 0.5,
                                offset: const Offset(-1, 1))
                          ]),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 22,
                      )),
                )
              : _selectedIndex == 3
                  ? InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 0.5,
                                    offset: const Offset(-1, 1))
                              ]),
                          child: const Icon(
                            Icons.settings_outlined,
                            size: 22,
                          )),
                    )
                  : const SizedBox(),
        ],
      ),
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: GNav(
        activeColor: colors(context).color1,
        color: Colors.grey.shade500,
        iconSize: 20,
        tabs: [
          GButton(
            icon: _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: _selectedIndex == 1 ? Icons.explore : Icons.explore_outlined,
            text: 'Explore',
          ),
          GButton(
            icon: _selectedIndex == 2 ? Icons.bookmark : Icons.bookmark_outline,
            text: 'Bookmark',
          ),
          GButton(
            icon:
                _selectedIndex == 3 ? Icons.person_2 : Icons.person_2_outlined,
            text: 'Profile',
          )
        ],
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
