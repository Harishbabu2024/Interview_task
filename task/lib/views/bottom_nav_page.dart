import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/views/post_page.dart';
import 'package:task/views/profile_page.dart';
import 'package:task/views/settings_page.dart';

class BottomNavPage extends StatefulWidget {
  final int initialIndex;
  final bool showLoginView;
  const BottomNavPage({
    super.key,
    this.initialIndex = 0,
    this.showLoginView = true,
  });

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Initialize pages once (to preserve state between tabs)
    _pages = [
      
      ProfilePage(),
      PostPage(),
      SettingsPage()
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await _onWillPop();
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 0),
                blurRadius: 4,
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.person, "Profile"),
                _buildNavItem(1, Icons.post_add_outlined,"Post"),
                _buildNavItem(2, Icons.settings, "Settings"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.1 : 1,
              duration: const Duration(milliseconds: 200),
              // child: ImageIcon(
              //   AssetImage(icon),
              //   color: isSelected ? AppColors.primaryColor : Colors.grey,
              // ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      SystemNavigator.pop();
      return false;
    }
  }
}