import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/service/auth_service.dart';
import 'package:flutter_diet_app/ui/pages/profile_screen.dart';
import 'package:flutter_diet_app/ui/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String email, password, bodyweight, height;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Form(
        key: formkey,
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 150),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("HOŞGELDİNİZ",style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: Colors.white,
                      ),),
                      subtitle: Text("Daha sağlıklı bir hayata ilk adımınız",style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    ),
                    SizedBox(height: 50),
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
      
                        //LOG IN BUTTON AREA
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
                                    final result = await authService.signIn(email, password);
                                    if (result == "success") {
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileScreen()), (route) => false);
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
                                  padding: const EdgeInsets.symmetric(horizontal:145.0),
                                  child: Text('Giriş Yap',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
      
                    SizedBox(height: 40),
      
                    //REGİSTER PAGE AREA
                    Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Üye değil misiniz?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white
                          ),
                          ),
                          GestureDetector(
                             onTap: () => {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RegisterPage()
                                ))
                            },
                            child: Text(
                              'Şimdi ÜCRETSİZ Deneyin', 
                               style: TextStyle(
                               color: Colors.yellow,
                               fontWeight: FontWeight.bold,
                               fontSize: 18
                          ),
                        ),
                       ),
                        
                      ],
                    ),
              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
