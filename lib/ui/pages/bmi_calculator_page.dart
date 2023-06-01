import 'package:flutter/material.dart';

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({Key? key}) : super(key: key);

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    double? height = double.tryParse(heightController.text);
    double? weight = double.tryParse(weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      setState(() {
        bmiResult = weight / ((height / 100) * (height / 100));
      });
    } else {
      setState(() {
        bmiResult = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16
            ),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 40),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                   icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                ListTile(
                  title: Text("BMI Nedir?",
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.white, 
                        ),
                      ),
                      subtitle: Text(
                        "BMI (Vücut Kitle İndeksi), boy-kilo endeksi olarak da bilinen, kişinin ağırlık ve boy değerleri kullanılarak hesaplanan bir sayıdır. Vücut kitle endeksi hesaplama sonucunda çıkan değer ile kişinin zayıf, normal ağırlıkta, hafif şişman ya da obez olması gibi bir sınıflama yapılır. ",
                          style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white, 
                        ),
                      ),
                ),

                SizedBox(height: 55),
                textField("Boy","Boyunuzu Santimetre (cm) Cinsinden Giriniz",heightController),
                SizedBox(height: 15),
                textField("Kilo","Kilonuzu Kilogram (kg) Cinsinden Giriniz",weightController),
                SizedBox(height: 25),

                

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    boxShadow: [ 
                      BoxShadow(
                      color: Colors.red,
                      blurRadius: 5,
                      offset: Offset(6, 8),
                    ),
                  ]
                  ),
                  child: TextButton(
                    onPressed: calculateBMI, 
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "BMI Hesapla",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black
                        ),
                        ),
                      )),
                ),
                SizedBox(height: 16.0),
            Text(
              'BMI Sonucu: ${bmiResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
              ],
            ),
            )
        ],
      ),
    );
  }

  TextField textField(String labelText, String hintText, TextEditingController controller) {
    return TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
  }

}