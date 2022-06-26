import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/screens/main_food_page/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List screens = [
    MainFoodPage(),
    Container(child: Center(child: Text('Cart Page'))),
    Container(child: Center(child: Text('Login Page'))),
    Container(child: Center(child: Text('Settings Page'))),
  ];

  selectedItems(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavigatorButton(
              backgroundColor: _currentIndex == 0 ? Colors.white : null,
              color: _currentIndex == 0 ? Colors.blue[200] : Colors.grey,
              icon: Icons.home,
              level: 'Home',
              onTap: () {
                selectedItems(0);
              },
            ),
            BottomNavigatorButton(
              backgroundColor: _currentIndex == 1 ? Colors.white : null,
              color: _currentIndex == 1 ? Colors.blue[200] : Colors.grey,
              icon: Icons.shopping_cart,
              level: 'Cart',
              onTap: () {
                selectedItems(1);
              },
            ),
            BottomNavigatorButton(
              backgroundColor: _currentIndex == 2 ? Colors.white : null,
              color: _currentIndex == 2 ? Colors.blue[200] : Colors.grey,
              icon: Icons.person,
              level: 'Login',
              onTap: () {
                selectedItems(2);
              },
            ),
            BottomNavigatorButton(
              icon: Icons.settings,
              backgroundColor: _currentIndex == 3 ? Colors.white : null,
              color: _currentIndex == 3 ? Colors.blue[200] : Colors.grey,
              level: 'Settings',
              onTap: () {
                selectedItems(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigatorButton extends StatelessWidget {
  final String? level;
  final Function()? onTap;
  final Color? color, backgroundColor;
  final IconData? icon;
  const BottomNavigatorButton({
    Key? key,
    this.level,
    required this.onTap,
    this.color = Colors.grey,
    required this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              level!,
              style: TextStyle(color: color, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

/*
BottomNavigationBar(
selectedItemColor: Colors.blue[200],
unselectedItemColor: Colors.grey,
unselectedFontSize: 16,
currentIndex: _currentIndex,
onTap: (index) {
setState(() {
_currentIndex = index;
});
},
items: [
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
BottomNavigationBarItem(
icon: Icon(Icons.shopping_cart), label: 'Cart'),
BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Login'),
BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
],
)*/
