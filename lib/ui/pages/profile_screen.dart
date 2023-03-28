import 'package:flutter/material.dart';
import 'package:flutter_diet_app/model/meal.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 225, 222),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
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
              label: "Home",
             ),
      
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.search),
              ),
              label: "Search",
             ),
      
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.person),
              ),
              label: "Person",
             ),
          ],
          ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: 350,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top:  380,
              left: 0,
              right: 0,
              child: Container(
                height: 870,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 32,
                        right: 16,
                      ),
                      child: Text(
                        "Bugün Yediklerim",
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 25,
                            ),
                            for (int i = 0; i < meals.length; i++) _MealCard(meal:meals[i]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    Expanded(
                      child: Container(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}


class _MealCard extends StatelessWidget {
  
  final Meal meal;

  const _MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 10,),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Image.asset(
                meal.imagePath,
                width: 150,
                fit: BoxFit.fitHeight,
                ),
              ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Text(meal.mealTime),
                  Text(meal.name),
                  Text(meal.kiloCalories),
                  Text(meal.timeTaken),
                  SizedBox(
                    height: 16
                  )
                ],
              )
              ),
          ],
        ),
      ),
    );
  }
}