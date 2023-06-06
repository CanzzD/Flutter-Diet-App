import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> getMealStream() {
    return FirebaseFirestore.instance
        .collection('addMeals')
        .where('userId', isEqualTo: user!.email)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getMeals() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('addMeals')
        .where('userId', isEqualTo: user!.email)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
