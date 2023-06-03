import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/ui/pages/login_page.dart';
import 'package:flutter_diet_app/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class fieldWrapper {
  String field = "";
  void setField(String value){field = value;}
}

class _RegisterPageState extends State<RegisterPage> {

  fieldWrapper email = new fieldWrapper(), password = new fieldWrapper() , bodyWeight = new fieldWrapper(), height = new fieldWrapper(), name = new fieldWrapper(), surname = new fieldWrapper();
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E9E9),
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
                        color: Colors.blueGrey,
                      ),),
                      subtitle: Text("Bize katılmak için bilgileri doldurmalısınız",style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),),
                    ),
                    
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.0),
                          textFormField("Ad", name),
                          SizedBox(height: 5.0),
                          textFormField("Soyad", surname),
                          SizedBox(height: 5.0),
                          textFormField("E-posta", email),
                          SizedBox(height: 5.0),
                          textFormField("Şifre", password, isObscured: true),
                          SizedBox(height: 5.0),
                          textFormField("Boy(cm)", height),
                          SizedBox(height: 5.0),
                          textFormField("Kilo(Kg)", bodyWeight),
                          SizedBox(height: 10.0),
                          signUpButton(),
                          SizedBox(height: 5.0),
                          backButton(context),
                          
                          
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

Container backButton(BuildContext context) {
    return Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                                  Navigator.of(context).pop();
                                },
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back_sharp,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Giriş Sayfasına Geri Dön",
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

Container signUpButton() {
    return Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                                    if (formkey.currentState!.validate()) {
                                      formkey.currentState!.save();
                                      final result = await authService.signUp(email.field, password.field, name.field, surname.field, bodyWeight.field, height.field);
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
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Üye Ol",
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

  TextFormField textFormField(String hintText, fieldWrapper onSavedValue, {bool isObscured: false}) {
    return TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri Eksiksiz Doldurunuz";
                            } else {}
                          },
                          onSaved: (value) {
                            onSavedValue.field = value!;
                          },
                          decoration: InputDecoration(
                            hintText: hintText,
                            filled: true,
                            fillColor: Colors.white.withOpacity(1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          obscureText: isObscured,
                        );
  }
}