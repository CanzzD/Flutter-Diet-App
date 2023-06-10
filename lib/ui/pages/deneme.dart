import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/add_meal_service.dart';
import 'package:gradient_progress_bar/gradient_progress_bar.dart';


class YemeklerSayfasi extends StatefulWidget {
  @override
  State<YemeklerSayfasi> createState() => _YemeklerSayfasiState();
}

class _YemeklerSayfasiState extends State<YemeklerSayfasi> {
    final AddMealService _addMealService = AddMealService();

     double value = 0.0;

      void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                   icon: Icon(
                    Icons.close,
                    color: Colors.blueGrey,
                    size: 40,
                    ),
                  ),
            GradientProgressIndicator(const [
              Colors.black,
              Colors.white,
            ], value)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            value = 0.6;
          });
        },
      ),
    );
  }
}

class TotalValuesWidget extends StatefulWidget {
  final String userId;

  const TotalValuesWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _TotalValuesWidgetState createState() => _TotalValuesWidgetState();
}

class _TotalValuesWidgetState extends State<TotalValuesWidget> {
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;
  double totalCalorie = 0;

  @override
  void initState() {
    super.initState();
    getTotalValues();
  }

  Future<void> getTotalValues() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('addMeals')
          .where('userId', isEqualTo: currentUser.email)
          .get();

      double protein = 0;
      double carbs = 0;
      double fat = 0;
      double calorie = 0;

      for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
        Map<String, dynamic>? data = docSnapshot.data();

        if (data != null && data.containsKey('protein') && data.containsKey('carbohydrate') && data.containsKey('fat') && data.containsKey('calorie')) {
          protein += double.tryParse(data['protein'].toString()) ?? 0;
          carbs += double.tryParse(data['carbohydrate'].toString()) ?? 0;
          fat += double.tryParse(data['fat'].toString()) ?? 0;
          calorie += double.tryParse(data['calorie'].toString()) ?? 0;
        }
      }

      setState(() {
        totalProtein = protein;
        totalCarbs = carbs;
        totalFat = fat;
        totalCalorie = calorie;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      //   Text('Toplam Kalori: $totalCalorie'),
      //   Text('Toplam Protein: $totalProtein'),
      //   Text('Toplam Karbonhidrat: $totalCarbs'),
      //   Text('Toplam Yağ: $totalFat'),
      // ],
    );
  }
}


