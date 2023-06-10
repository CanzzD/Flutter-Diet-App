import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> getTotalValues() async {
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
        double protein = double.tryParse(data['protein'].toString()) ?? 0;
        double carbs = double.tryParse(data['carbohydrate'].toString()) ?? 0;
        double fat = double.tryParse(data['fat'].toString()) ?? 0;
        double calorie = double.tryParse(data['calorie'].toString()) ?? 0;

        // Toplam değerlere ekleyin
        totalProtein += protein;
        totalCarbs += carbs;
        totalFat += fat;
        totalCalorie += calorie;
      }
    }

    // Sonuçları ekrana yazdırın
    print('Toplam Kalori: $totalCalorie');
    print('Toplam Protein: $totalProtein');
    print('Toplam Karbonhidrat: $totalCarbs');
    print('Toplam Yağ: $totalFat');
  }
}
