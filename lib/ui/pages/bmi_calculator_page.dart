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
      backgroundColor: Color(0xFFE9E9E9),
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
                    color: Colors.blueGrey,
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
                          color: Colors.blueGrey, 
                        ),
                      ),
                      subtitle: Text(
                        "BMI (Vücut Kitle İndeksi), boy-kilo endeksi olarak da bilinen, kişinin ağırlık ve boy değerleri kullanılarak hesaplanan bir sayıdır. Vücut kitle endeksi hesaplama sonucunda çıkan değer ile kişinin zayıf, normal ağırlıkta, hafif şişman ya da obez olması gibi bir sınıflama yapılır. ",
                          style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.blueGrey, 
                        ),
                      ),
                ),

                SizedBox(height: 55),
                textField("Boy","Boyunuzu Santimetre (cm) Cinsinden Giriniz",heightController),
                SizedBox(height: 15),
                textField("Kilo","Kilonuzu Kilogram (kg) Cinsinden Giriniz",weightController),
                SizedBox(height: 25),
                calculateButton(),
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
Container calculateButton() {
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
      onTap: calculateBMI,
      borderRadius: BorderRadius.circular(25),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate_outlined,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 8),
            Text(
              "BMI Hesapla",
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
  
TextField textField(String labelText, String hintText, TextEditingController controller) {
    return TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                  labelStyle: TextStyle(
                    color: Color(0xFF5563C1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
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