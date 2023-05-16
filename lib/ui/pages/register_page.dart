import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/ui/pages/login_page.dart';
import 'package:flutter_diet_app/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late String email, password, bodyWeight, height, name, surname;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

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
              vertical: 90.0
            ),
            child: Column(
              children: <Widget>[
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
                    
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.0),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              name = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'Ad',
                              filled: true,
                              fillColor: Colors.white.withOpacity(1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              surname = value!;
                            },
                            decoration: InputDecoration(
                              hintText: 'Soyad',
                              filled: true,
                              fillColor: Colors.white.withOpacity(1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
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
                          SizedBox(height: 5.0),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bilgileri Eksiksiz Doldurunuz";
                              } else {}
                            },
                            onSaved: (value) {
                              bodyWeight = value!;
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
                                      final result = await authService.signUp(email, password, name, surname, bodyWeight, height);
                                      if (result == "success") {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Aramıza Hoşgeldiniz. Giriş Yapabilirsiniz")));
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                    } else {
                                      showDialog(
                                        context: context, 
                                        builder: (context) {
                                          return AlertDialog(
                                        title: Text("Hata"),
                                        content: Text(result!),
                                        );
                                      });
                                    }
                                    } else {
                                      
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:150.0),
                                    child: Text('Kayıt Ol',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:100.0),
                                    child: Text('Giriş Ekranına Dön',style: TextStyle(
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