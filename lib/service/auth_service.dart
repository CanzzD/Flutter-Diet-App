import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;


  Future forgotPassword(String email) async {
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      print("Mailinize göndeilen bağlantıdan şifrenizi yenileyebilirsiniz"); 
    } catch (e) {
    }
  }

  Future<String?> signIn(String email, String password) async {
    String? res;

    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Kullanıcı Bulunamadı";
      } else if (e.code == "wrong-password") {
        res = "Şifre Hatalı";
      }

    }
    return res;
  }

  Future<String?> signUp(String email, String password, String name, String surname, String height, String bodyWeight) async {
    String? res;

    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
      try {
        final resultData = await firebaseFirestore.collection("User").add({
          "name" : name,
          "surname" : surname,
          "email" : email,
          "height" : height,
          "bodyWeight" : bodyWeight,
        });
      } catch (e) {
        print("$e");
      }
      res = "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
        res = "Mail Zaten Kayıtlı";
          break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
          res = "Geçersiz Mail Adresi";
          break;
        default:
        res = "Bir hata ile karşılaşıldı, tekrar deneyiniz";
        break;
      }    
    }
    return res;
  }

  Future<String?> addMeal(String mealName, String calorie, String protein, String carbohydrate, String fat, String mealType) async {
    String? res;

      try {
        final resultData = await firebaseFirestore.collection("User").add({
          "mealName" : mealName,
          "calorie" : calorie,
          "protein" : protein,
          "carbohydrate" : carbohydrate,
          "fat" : fat,
          "mealType": mealType,
        });
      } catch (e) {
        print("$e");
      }
      res = "success";
    }

    
  }
