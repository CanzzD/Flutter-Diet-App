import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, double>?> getTotalValues() async {
  // Geçerli kullanıcının kimlik bilgilerini alın
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    // Firestore'dan "addMeals" koleksiyonunu kullanıcının kimliğiyle filtreleyin
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('addMeals')
        .where('userId', isEqualTo: currentUser.email)
        .get();

    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalCalorie = 0;

    // Her doküman için döngü
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot in querySnapshot.docs) {
      // Dokümanın veri alanlarına erişin
      Map<String, dynamic>? data = docSnapshot.data();

      if (data != null && data.containsKey('protein') && data.containsKey('carbohydrate') && data.containsKey('fat') && data.containsKey('calorie')) {
        // Protein, karbonhidrat ve yağ değerlerini alın

        double calorie = double.tryParse(data['calorie'].toString()) ?? 0;
        double carbohydrate = double.tryParse(data['carbohydrate'].toString()) ?? 0;
        double fat = double.tryParse(data['fat'].toString()) ?? 0;
        double protein = double.tryParse(data['protein'].toString()) ?? 0;

        // Toplam değerlere ekleyin

        totalCalorie += calorie;
        totalCarbs += carbohydrate;
        totalProtein += protein;
        totalFat += fat;
      }
    }

    return {
      'totalCalorie': totalCalorie,
      'totalCarbs': totalCarbs,
      'totalProtein': totalProtein,
      'totalFat': totalFat,
    };
  }
}
