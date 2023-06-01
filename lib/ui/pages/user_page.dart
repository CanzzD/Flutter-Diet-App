import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  String userName = '';

  @override
  void initState() {
    super.initState();
    // Kullanıcı adını almak için Firebase kullanıcısını dinleyin
    getUserDisplayName();
  }

  void getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Firestore'dan kullanıcı adını almak için sorgu yapın
      DocumentSnapshot snapshot = (await FirebaseFirestore.instance
          .collection("User")
          .where("email",isEqualTo: user.email)
          .get()).docs.first;
      
      // Kullanıcı adını saklamak için bir değişkene atayalım
      setState(() {
        userName = snapshot['name'];
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: ListTile(
                        title: Text(
                          "Selam  " + userName.toUpperCase(),
                          style:  TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.black,
                        ),),
          
                        subtitle: Text(
                          "Bu alan senin kendini daha iyi tanıyabilmen için tasarlanmıştır",
                          style:  TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),),
                      ),
          ),
          userPageTextButton("Vücut Kitle İndexi (BMI) Hesaplama", "/bmiCalculatorPage"),
          userPageTextButton("Vücut Yağ Oranı Hesaplama             ", ""),
        ],
      ),
    );
  }


  Padding userPageTextButton(String buttonText,String navpage) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red,
                  blurRadius: 8,
                  offset: Offset(6, 8),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, navpage), 
              child: Text(buttonText ,style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 23
              ),),
              ),
          ),
    );
  }
}