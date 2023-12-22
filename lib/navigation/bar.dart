import 'package:flutter/material.dart';
import 'package:mobile_studio_gallery/menu/tampilan_utama.dart';
import 'package:mobile_studio_gallery/pesanan/tampilan_pesanan_new.dart';

import 'package:mobile_studio_gallery/main.dart';

import 'package:mobile_studio_gallery/user/data_pribadi.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final List<String> pageLabels = ['Home', 'Pesanan', 'Google Maps', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF232D3F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
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
                MaterialPageRoute(builder: (context) => PesananPage2()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyMap()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Tampilan()),
              );
              break;
          }
        },
      ),
    );
  }

  Icon getIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.home, color: Colors.white);
      case 1:
        return Icon(Icons.shopping_cart, color: Colors.white);
      case 2:
        return Icon(Icons.map, color: Colors.white);
      case 3:
        return Icon(Icons.person, color: Colors.white);

      default:
        return Icon(Icons.home, color: Colors.white);
    }
  }
}
