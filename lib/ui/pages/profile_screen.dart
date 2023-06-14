import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';
import '../../services/add_meal_service.dart';
import '../../services/calculate_macro_service.dart';


final AddMealService _addMealService = AddMealService();
FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  DateTime _dateTime = DateTime.now();
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> mealList = [];

  double? totalCalorie = 10;
  double? totalCarbs = 10;
  double? totalProtein = 10;
  double? totalFat = 10;

  @override
  void initStates() {
    super.initState();
    fetchMeals();
  }


  Future<void> fetchMeals() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('addMeals')
        .where('userEmail', isEqualTo: user!.email)
        .get();

    setState(() {
      mealList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  void setTotalCalorie() {
    getTotalValues().then((value) => {
      totalCalorie = value!["totalCalorie"],
      totalCarbs = value["totalCarbs"],
      totalProtein = value["totalProtein"],
      totalFat = value["totalFat"],
    });
  }

  @override
  void initState() {
    super.initState();
    // Kullanıcı adını almak için Firebase kullanıcısını dinleyin
    getUserDisplayName();
    setTotalCalorie();
  }

  void getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Firestore'dan kullanıcı adını almak için sorgu yapın
      DocumentSnapshot snapshot = (await FirebaseFirestore.instance
          .collection("User")
          .where("email",isEqualTo: user.email)
          .get()).docs.first;
      
      // Kullanıcı adını saklamak için bir değişkene atayalım
      setState(() {
        userName = snapshot['name'];
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2025)
      ).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: 350,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 40, left: 30, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)} ",
                        style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color:  Colors.black 
                      ),
                      ),

                      subtitle: Text(
                        "Merhaba  " + userName.toUpperCase(),
                        style:  TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 23,
                        color: Colors.black,
                      ),      
                    ),
                    ),

                    Row(
                      children: <Widget>[

                        _RadialProgress(
                          height: height * 0.24, 
                          width: width * 0.4, 
                          progress: totalCalorie! / 2300,
                          calorieText: totalCalorie!,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            _IngredientProgress(
                              ingredient: "Karbonhidrat", 
                              leftAmount: totalCarbs!.toStringAsFixed(2), 
                              progress: totalCarbs! / 250, 
                              progressColor: Colors.blueGrey.shade500, 
                              width: 100),
                              SizedBox(height: 10),

                              _IngredientProgress(
                              ingredient: "Protein", 
                              leftAmount: totalProtein!.toStringAsFixed(2), 
                              progress: totalProtein! / 110, 
                              progressColor: Colors.blueGrey.shade500, 
                              width: 100),
                              SizedBox(height: 10),

                              _IngredientProgress(
                              ingredient: "Yağ", 
                              leftAmount: totalFat!.toStringAsFixed(2), 
                              progress: totalFat! / 65, 
                              progressColor: Colors.blueGrey.shade500, 
                              width: 100),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
                ),
              ),
            ),
            Positioned(
              top:  370,
              left: 0,
              right: 0,
              child: Container(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            right: 16,
                          ),
                          child: Text(
                            "Bugün Yediklerim",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal:50),
                        //   child: MaterialButton(
                        //     onPressed: _showDatePicker,
                        //     child: Padding(padding: EdgeInsets.all(0),
                        //     child: Text(
                        //       "Tarih Seçin",
                        //     ),
                        //     ),
                        //     )
                        // ),
                      ],
                    ),
      
                    //MEAL-CARD-AREA
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            _MealCard()
                          ],
                        ),
                      ),
                    ),
                    

                    //WATER-TRACKER-AREA
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 0,left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          color: Colors.blueGrey.shade300
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pushNamed(context, "/waterTrackerScreen"), 
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal:40),
                            child: Text(
                              "İçtiğiniz Su Miktarını Takip Etmek İçin Tıklayınız",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }





  Material newTextButton(String text,BuildContext context,String onTap) {
    return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => Navigator.pushNamed(context, onTap),
      borderRadius: BorderRadius.circular(25),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range,
              color: Colors.blueGrey,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final String? leftAmount;
  final double? width;
  final double progress;
  final Color progressColor;

  const _IngredientProgress({super.key, required this.ingredient, required this.leftAmount, required this.progress, required this.progressColor, required this.width});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(ingredient.toUpperCase(), style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFFE9E9E9),
                    border: Border.all(color: Colors.black)
                  ),
                ),
                Container(
                  height: 10,
                  width: width! * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: progressColor,
                    border: Border.all(color: Colors.black)
                  ),
                ),
              ],
            ),
            Text("${leftAmount} gram ")
          ],
        )
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {


  final double height, width, progress,calorieText;

 _RadialProgress({Key? key, required this.height, required this.width, required this.progress, required this.calorieText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: progress,
        ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: calorieText.toString(), style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey.shade500,
                ),),
                TextSpan(text: "\n"),
                TextSpan(text: "kcal", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade500,
                ),),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {

  final double progress;
  _RadialPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..strokeWidth = 7
      ..color = Colors.blueGrey.shade500
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: size.width/2), 
        math.radians(-90), 
        math.radians(-relativeProgress), 
        false, 
        paint,
        );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class _MealCard extends StatelessWidget {

   void _removeMeal(String id) {
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return StreamBuilder<QuerySnapshot>(
        stream: _addMealService.getMealStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Veriler alınırken bir hata oluştu.'),
            );
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> meals = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: meals.map((meals) {
                  Map<String, dynamic>? mealsData = meals.data() as Map<String, dynamic>?;
                  if (mealsData != null && mealsData.containsKey('mealName')) {
                    String mealName = mealsData['mealName'] as String;
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(decoration: 
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        width: 250,
                        height: 300,
                        child: Card(color: Colors.white, elevation: 20,
                          child: Container(decoration: BoxDecoration(gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE9E9E9), Colors.blueGrey.shade500
                            ],
                          ),borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.black)
                          ),
                            margin: const EdgeInsets.only(right: 8, bottom: 10,top: 10,left: 8),
                            child: Material(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              elevation: 0,color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[                    
                                CircleAvatar(backgroundImage: NetworkImage(mealsData['imageUrl']),radius: 55,),
                                Text(mealsData["mealName"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Kalori:   " + mealsData["calorie"] + "kcal"),
                                Text("Karbonhidrat:" + mealsData["carbohydrate"] + "g"),
                                Text("Protein:  " + mealsData["protein"] + "g"),
                                Text("Yağ:  " + mealsData["fat"] + "g"),

                                IconButton(onPressed: () {_removeMeal(meals.id);}, icon: Icon(Icons.delete,color: Colors.white,size: 25,)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:75),
            child: Center(
              child: Text(
                'Henüz Yemek Eklemediniz',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey
                ),
                ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('Kullanıcı oturumu açmamış.'),
      );
    }
  }
}
