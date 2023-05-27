import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void searchMeals(String searchQuery) {

    final firebaseFirestore = FirebaseFirestore.instance
        .collection('Meals')
        .where('searchCases', arrayContains: searchQuery.toUpperCase())
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _searchResults = snapshot.docs;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
      body: Column(
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Aramak İstediğiniz Besini Girin',
              ),
              onChanged: (value) {
                searchMeals(value);
              },
            ),
          ),        
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> mealData = _searchResults[index].data() as Map<String, dynamic>;
                String mealName = mealData['mealName'] ?? '';
                String calorie = mealData['calorie'] ?? '';
                String protein = mealData['protein'] ?? '';
                String carbohydrate = mealData['carbohydrate'] ?? '';
                String fat = mealData['fat'] ?? '';
                String image = mealData['image'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)
                      ),
                    child: Column(
                      children: [
                        Text(mealName,
                         style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20
                         )
                        ),
                  
                        Text("Kalori:    " + calorie + "kcal"),
                        Text("Karbonhidrat:    " + carbohydrate + "g"),
                        Text("Protein:   " + protein + "g"),
                        Text("Yağ:   " + fat + "g"),
                        Text("foto" + image)
                      ],
                     
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}