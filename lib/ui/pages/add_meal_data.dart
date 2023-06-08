import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/auth_service.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({Key? key}) : super(key: key);

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  late String mealName, calorie, protein, carbohydrate, fat, imageUrl;
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
      body: Form(
        key: formkey,
        child: Column(
          children: [Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 90
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Geçici olarak Firestore'a veri eklemek için kullanılacak sayfa",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              mealName = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "Besin İsmi",
                            filled: true
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              calorie = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "Kalorisi(1 Porsiyon)",
                            filled: true
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              protein = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "Protein",
                            filled: true
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              carbohydrate = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "Karbonhidrat",
                            filled: true
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              fat = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "Yağ",
                            filled: true
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              imageUrl = value!;
                            },
                          decoration: InputDecoration(
                            hintText: "İmageURL",
                            filled: true
                          ),
                        ),
                
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      formkey.currentState!.save();
                                      authService.addMeal(mealName, calorie, protein, carbohydrate, fat, imageUrl);
                                    } else {
                                      
                                    }
                                  }, 
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 130),
                                  child: Text(
                                    "Besin Ekle",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              )],

        ),
        ),
    );
  }
}