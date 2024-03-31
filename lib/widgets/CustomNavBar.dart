import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home, label: 'Home', route: 'homepage'),
    NavigationItem(icon: Icons.category, label: 'Category', route: 'categoryPage'),
    NavigationItem(icon: Icons.favorite, label: 'Favorites', route: 'userpage'),
    NavigationItem(icon: Icons.person, label: 'Profile', route: 'profilePage'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF292B37),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _navigationItems.length,
          (index) => NavigationItemWidget(
            item: _navigationItems[index],
            isSelected: _selectedIndex.value == index,
            onTap: () {
              _selectedIndex.value = index;
              Navigator.pushNamed(context, _navigationItems[index].route);
            },
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class NavigationItemWidget extends StatelessWidget {
  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 35,
            color: Colors.amber
          ),
          SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}