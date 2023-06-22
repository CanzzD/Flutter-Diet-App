import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  List<DocumentSnapshot> _allMeals = []; // Tüm yemeklerin listesini tutmak için yeni bir liste ekleyin
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('addMeals');

  late User? currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchAllMeals(); // Tüm yemekleri almak için initState içinde yeni bir metot çağırın
  }

  void _getCurrentUser() async {
    final User? user = _auth.currentUser;
    setState(() {
      currentUser = user;
    });
  }

  void _addMeal(
      String mealName,
      String calorie,
      String protein,
      String carbohydrate,
      String fat,
      String imageUrl) async {
    if (currentUser != null) {
      final userDocRef = _userCollection.doc();
      await userDocRef.set({
        "mealName": mealName.toUpperCase(),
        "calorie": calorie,
        "protein": protein,
        "carbohydrate": carbohydrate,
        "fat": fat,
        "imageUrl": imageUrl,
        'userId': currentUser!.email,
        'addedDate': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Yemek eklendi.'),
        ),
      );
    }
  }

  void searchMeals(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      final firebaseFirestore = FirebaseFirestore.instance
          .collection('Meals')
          .where('searchCases', arrayContains: searchQuery.toUpperCase())
          .get()
          .then((QuerySnapshot snapshot) {
        setState(() {
          _searchResults = snapshot.docs;
        });
      });
    } else {
      setState(() {
        _searchResults = _allMeals; // Arama yapılmadığında tüm yemeklerin listesini göster
      });
    }
  }

  void _fetchAllMeals() {
    _userCollection.get().then((QuerySnapshot snapshot) {
      setState(() {
        _allMeals = snapshot.docs;
        _searchResults = _allMeals; // İlk başta tüm yemeklerin listesini göster
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
                Map<String, dynamic> mealData =
                    _searchResults[index].data() as Map<String, dynamic>;
                String mealName = mealData['mealName'] ?? '';
                String calorie = mealData['calorie'] ?? '';
                String protein = mealData['protein'] ?? '';
                String carbohydrate = mealData['carbohydrate'] ?? '';
                String fat = mealData['fat'] ?? '';
                String imageUrl = mealData['imageUrl'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                      border: Border.all(color: Colors.black),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFE9E9E9),
                          Colors.blueGrey.shade500
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            _addMeal(
                                mealName,
                                calorie,
                                protein,
                                carbohydrate,
                                fat,
                                imageUrl);
                          },
                          icon: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          radius: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              mealName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text("Kalori:    " + calorie + "kcal"),
                            Text("Karbonhidrat:    " + carbohydrate + "g"),
                            Text("Protein:   " + protein + "g"),
                            Text("Yağ:   " + fat + "g"),
                          ],
                        ),
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
