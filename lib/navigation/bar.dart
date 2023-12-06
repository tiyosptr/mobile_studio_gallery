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

  final List<String> pageLabels = ['Home', 'Histori', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      currentIndex: currentIndex,
      items: List.generate(
        pageLabels.length,
        (index) => BottomNavigationBarItem(
          icon: getIcon(index),
          label: pageLabels[index],
        ),
      ),
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaketApp()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PesananPage()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tampilan()),
            );
            break;
        }
      },
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
}
