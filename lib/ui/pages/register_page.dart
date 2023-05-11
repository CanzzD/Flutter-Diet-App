import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/ui/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late String email, password, bodyweight, height;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Form(
        key: formkey,
        child: Column(
          children: [Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 50.0
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 50,
                      ),onPressed: () {
                        Navigator.of(context).pop();
                      },
                      ),
                  ),
                  SizedBox(height: 120),
                  ListTile(
                      title: Text("NEREDEYSE OLDU",style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.white,
                      ),),
                      subtitle: Text("Bize katılmak için bilgileri doldurmalısınız",style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 32.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri Eksiksiz Doldurunuz";
                            } else {}
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'E-posta',
                            filled: true,
                            fillColor: Colors.white.withOpacity(1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri Eksiksiz Doldurunuz";
                            } else {}
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'Şifre',
                            filled: true,
                            fillColor: Colors.white.withOpacity(1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri Eksiksiz Doldurunuz";
                            } else {}
                          },
                          onSaved: (value) {
                            height = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'Boy(cm)',
                            filled: true,
                            fillColor: Colors.white.withOpacity(1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri Eksiksiz Doldurunuz";
                            } else {}
                          },
                          onSaved: (value) {
                            bodyweight = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'Kilo(Kg)',
                            filled: true,
                            fillColor: Colors.white.withOpacity(1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        //SIGN UP BUTTON
                        SizedBox(height: 25.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                    try {
                                      var userResult = 
                                      await firebaseAuth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                        formkey.currentState!.reset();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Tebrikler Aramıza Hoşgeldiniz. Giriş Sayfasına Yönlendiriliyorsunuz."),
                                            ),
                                        );
                                        Navigator.pushReplacementNamed(context, "/loginPage");
                                    } catch (e) {
                                      print(e.toString()); 
                                    }
                                  } else {
                                    
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:160.0),
                                  child: Text('Üye ol',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}