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