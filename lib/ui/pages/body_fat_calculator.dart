import 'package:flutter/material.dart';

class BodyFatCalculatorPage extends StatefulWidget {
  const BodyFatCalculatorPage({Key? key}) : super(key: key);

  @override
  State<BodyFatCalculatorPage> createState() => _BodyFatCalculatorPageState();
}

class _BodyFatCalculatorPageState extends State<BodyFatCalculatorPage> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool isMale = true;
  double bodyFatPercentage = 0;

  void calculateBodyFat() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    int age = int.tryParse(ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      double leanBodyMass;
      double bodyFatMass;

      if (isMale) {
        leanBodyMass = (0.407 * weight) + (0.267 * height) - 19.2;
        bodyFatMass = weight - leanBodyMass;
      } else {
        leanBodyMass = (0.252 * weight) + (0.473 * height) - 48.3;
        bodyFatMass = weight - leanBodyMass;
      }

      double bodyFatPercentage = (bodyFatMass / weight) * 100;

      setState(() {
        this.bodyFatPercentage = bodyFatPercentage;
      });
    }
  }

  String bodyFatData() {
    if (bodyFatPercentage == 0) {
      return "Yağ oranınız 0-10 aralığında ise GEREKLİ YAĞ.\nYağ oranınız 10-17 aralığında ise SPORCU.\nYağ oranınız 17-22 aralığında ise FORMDA.\nYağ oranınız 22-27 ve üzeri ise ORTALAMA.\nYağ oranınız 27 ve üzeri ise OBEZİTE BAŞLANGICI.";
    }
    else if (bodyFatPercentage < 10) {
      return "VÜCUT YAĞ ORANI hesaplama sonucuna göre yağ oranınız yaşamak için gerekli seviyededir ancak üst düzey sporcu değilseniz bu yağ oranları tehlikeli olabilir. İdeal yağ oranına ulaşma sürecinde önemli olan yağ artışının hızlı olması değil; sağlıklı bir yağ artışının gerçekleşmesidir. Bu süreçte bir beslenme uzmanında yardım almanız daha sağlıklı olur.";
    } else if (10 < bodyFatPercentage && bodyFatPercentage < 17) {
      return "VÜCUT YAĞ ORANI hesaplama sonucuna göre yağ oranınız sporcuların yağ oranları seviyelerindedir. Bu yağ oranında olmanız hem daha dinç ve zinde olmanızı sağlar hem de hastalıklara yakalanma riskinizi düşürür.";
    } else if (17 < bodyFatPercentage && bodyFatPercentage < 22) {
      return "VÜCUT YAĞ ORANI hesaplama sonucuna göre yağ oranınız vücudunuzun formda olduğunu gösteriyor. Bu yağ oranını korumak için şekerli ve yağlı gıdalardan uzak durun ve spor yapın.";
    } else if (22 < bodyFatPercentage && bodyFatPercentage < 27) {
      return "VÜCUT YAĞ ORANI hesaplama sonucuna göre yağ oranınızın ortalama seviyelerde olduğu görülüyor. Bu yağ oranlarında iseniz mutlakla daha dikkatli olmanız gerekmektedir. Çünkü eğer beslenmenize dikkat etmezseniz, bir de hareketsiz bir yaşantınız var ise Obezite riski taşımaktasınız.";
    }else if (bodyFatPercentage > 27) {
      return "VÜCUT YAĞ ORANI hesaplama sonucuna göre yağ oranınız obezite başlangıcı sınıflandırmasına giriyor ve vücut yağ oranınızın olması gerekenin üstünde olduğunu gösteriyor. Obezite diyabet, kalp-damar hastalıkları, yüksek tansiyon, kolesterol ve kanser görülme riskini artırabilir ve yaşam kalitesini olumsuz yönde etkileyebilir. İdeal yağ oranına ulaşmak amacıyla hızlı kilo kaybının gerçekleşmesi kalıcı olmayan bir çözümdür ve aynı hızla artışına neden olabilir. Bu süreçte yağ oranı kaybının diyetisyen gözetiminde olmasını tavsiye ediyoruz.";
    }
    return "";
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
                Padding(padding: EdgeInsets.only(top: 30),
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
                SizedBox(height: 15),
                ListTile(
                  title: Text("Vücut Yağ Oranı Nedir?",
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 29,
                          color: Colors.blueGrey, 
                        ),
                      ),
                      subtitle: Text(
                        "Vücut Yağ Oranı, kişinin toplam vücut yağının toplam vücut ağırlığına oranıdır. Vücut Yağ Oranı size vücudunuzdaki yağın gerçek ağırlığının bilgisini verir.",
                          style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.blueGrey, 
                        ),
                      ),
                ),
              
            SizedBox(height: 15),
            textField("Boy","Boyunuzu Santimetre (cm) Cinsinden Giriniz",heightController),
            SizedBox(height: 10),
            textField("Kilo","Kilonuzu Kilogram (kg) Cinsinden Giriniz",weightController),
            SizedBox(height: 10),
            textField("Yaş","Yaşınızı Giriniz",ageController),
            SizedBox(height: 10),
            listTile("Erkek", true),
            listTile("Kadın", false),
            calculateButton(),
            SizedBox(height: 10),
            
            Text(
              'Vücut Yağ Oranınız: ${bodyFatPercentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 15),

            Text(
                  "${bodyFatData()}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

ListTile listTile(String text, bool value) {
    return ListTile(
            title: Text(text),
            leading: Radio(
              value: value,
              groupValue: isMale,
              onChanged: (value) {
                setState(() {
                  isMale = value!;
                });
              },
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
      onTap: calculateBodyFat,
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
              "Vücut Yağ Oranınızı Hesaplayın",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
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
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
  }

}