import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        children: [Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.0,
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
                SizedBox(height: 30),
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
            ],
          ),
          )
        ],
      ),
    );
  }
}