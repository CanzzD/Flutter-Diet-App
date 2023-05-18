import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/ui/pages/profile_screen.dart';
import 'package:flutter_diet_app/ui/pages/search_page.dart';
import 'package:flutter_diet_app/ui/pages/user_page.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  List pages = [
    ProfileScreen(),
    SearchPage(),
    UserPage(),
  ];

  int currentIndex = 0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          iconSize: 35, 
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF200087),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          items: [
      
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home ),
              ),
              label: "Anasayfa",
             ),
      
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.search),
              ),
              label: "Besin Ara",
             ),
      
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person),
              ),
              label: "Kullanıcı Paneli",
             ),
          ],
          ),
      ),
    );
  }
}