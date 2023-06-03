import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/service/auth_service.dart';
import 'package:flutter_diet_app/ui/pages/bottom_navbar_page.dart';
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
      backgroundColor: Color(0xFFE9E9E9),
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
                        color: Colors.blueGrey,
                      ),),
                      subtitle: Text("Daha sağlıklı bir hayata ilk adımınız",style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.blueGrey,
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
                        logInButton(),
      
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
                            fontSize: 16,
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
                               color: Colors.blueGrey,
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

  Container logInButton() {
    return Container(
                        width: double.infinity,
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            colors: [Color(0xFF74ABE2), Color(0xFF5563C1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState!.save();
                                    final result = await authService.signIn(email, password);
                                    if (result == "success") {
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomNavigationBarPage()), (route) => false);
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
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),);
  }
}
