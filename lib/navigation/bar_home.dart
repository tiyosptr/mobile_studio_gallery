import 'package:flutter/material.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/user/data_pribadi.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          if (currentIndex == 0) PaketApp(),
          if (currentIndex == 1) PesananPage(),
          if (currentIndex == 2) Tampilan(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: currentIndex,
        items: List.generate(
          3,
          (index) => BottomNavigationBarItem(
            icon: getIcon(index),
            label: getPageLabel(index),
          ),
        ),
        onTap: (int index) {
          switchPage(index);
        },
      ),
    );
  }

  Icon getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.home, color: Colors.white);
      case 1:
        return Icon(Icons.history, color: Colors.white);
      case 2:
        return Icon(Icons.person, color: Colors.white);
      default:
        return Icon(Icons.home, color: Colors.white);
    }
  }

  String getPageLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Histori';
      case 2:
        return 'Profile';
      default:
        return 'Home';
    }
  }

  void switchPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
