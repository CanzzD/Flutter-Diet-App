import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;


  Future<String?> signIn(String email, String password) async {
    String? res;

    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Kullanıcı Adı veya Şifre Hatalı";
      } else if (e.code == "wrong-password") {
        res = "Kullanıcı Adı veya Şifre Hatalı";
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

  Future<String?> addMeal(String mealName, String calorie, String protein, String carbohydrate, String fat, String imageUrl) async {
    String? res;


      try {
        final resultData = await firebaseFirestore.collection("Meals").add({
          "mealName" : mealName.toUpperCase(),
          "calorie" : calorie,
          "protein" : protein,
          "carbohydrate" : carbohydrate,
          "fat" : fat,
          "imageUrl": imageUrl,
          "searchCases": setSearchParam(mealName.toUpperCase())
        });
      } catch (e) {
        print("$e");
      }
      res = "success";
    }

    setSearchParam(String caseNumber) {
      List<String> caseSearchList = [];
      String temp = "";
      for (int i = 0; i < caseNumber.length; i++) {
        temp = temp + caseNumber[i];
        caseSearchList.add(temp);
  }
    List<String> splittedCaseNumber = caseNumber.split(" ");
    for (var i = 0; i < splittedCaseNumber.length; i++) {
      String splittedTemp = ""; 
      for (var j = 0; j < splittedCaseNumber[i].length; j++) {
        splittedTemp = splittedTemp + splittedCaseNumber[i][j];
        caseSearchList.add(splittedTemp);
      }
    }
      return caseSearchList;
}

    
  }
