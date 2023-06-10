import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMealService {
  final User? user = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> getMealStream() {
    return FirebaseFirestore.instance
        .collection('addMeals')
        .where('userId', isEqualTo: user!.email)
        .snapshots();
  }
}
