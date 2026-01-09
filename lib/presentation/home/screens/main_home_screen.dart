import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/screens/home.dart';
import 'package:movin/presentation/home/widgets/for_sale_screen.dart';
import 'package:movin/presentation/profile/model/profile_model.dart';

class MainHomeScreen extends StatefulWidget {
  //final ProfileModel currentProfile;  
  const MainHomeScreen({super.key, });

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _index = 0;

  final List pages = [
    const HomePage(),
    const ForSaleScreen(),
    const ForSaleScreen(), //ForRentScreen(),
    const ForSaleScreen(), //CommericalScreen(),
    const ForSaleScreen(), //investmentsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,

        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.navyDark,

        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'For Sale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.key_outlined),
            label: 'For Rent',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment_outlined),
            label: 'Commerical',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: 'Investments',
          ),
        ],
      ),
    );
  }
}
