import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_app/model/meal.dart';
import 'package:flutter_diet_app/ui/pages/water_tracker.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    // Kullanıcı adını almak için Firebase kullanıcısını dinleyin
    getUserDisplayName();
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
                padding: const EdgeInsets.only(top: 40, left: 32, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)} ",
                        style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18, 
                      ),
                      ),

                      subtitle: Text(
                        "Merhaba  " + userName.toUpperCase(),
                        style:  TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                        color: Colors.black,
                      ),),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        _RadialProgress(
                          width:  width * 0.35,
                          height: width * 0.4, 
                          progress: 0.7,  
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _IngredientProgress(
                              ingredient: "Protein",
                              leftAmount: 75, 
                              progress: 0.6, 
                              progressColor: Colors.green,
                              width: width * 0.28,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            _IngredientProgress(
                              ingredient: "Karbonhidrat", 
                              leftAmount: 254, 
                              progress: 0.4, 
                              progressColor: Colors.red,
                              width: width * 0.28,
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            _IngredientProgress(
                              ingredient: "Yağ", 
                              leftAmount: 63, 
                              progress: 0.8, 
                              progressColor: Colors.yellow,
                              width: width * 0.28,
                            ),
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
              top:  380,
              left: 0,
              right: 0,
              child: Container(
                height: 445,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 32,
                        right: 16,
                      ),
                      child: Text(
                        "Bugün Yediklerim",
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    
                    //MEAL-CARD-AREA
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 25,
                            ),
                            for (int i = 0; i < meals.length; i++) _MealCard(meal:meals[i]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:15),

                    //WATER-TRACKER-AREA
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => (WaterTrackerScreen())
                          ),
                        );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 27, right: 27),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                              Color.fromARGB(255, 220, 225, 222),
                              Color(0xFF2000980),
                            ],
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top:25.0),
                                child: Text(
                                  "BUGÜN NE KADAR SU İÇTİM?",
                                  style: TextStyle(
                                    color: Color(0xFF2000980),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                              ),
                                //WATER PROGRESS BAR
                                SizedBox(height: 30,),

                                 Padding(
                                   padding: const EdgeInsets.all(15.0),
                                   child: _WaterProgressBar(height: 0.1, width: 0.1, percent: 0),
                                 ),
                              Row(),
                            ],
                          ),
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
}



class _IngredientProgress extends StatelessWidget {

  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress({Key? key, required this.ingredient, required this.leftAmount, required this.progress, required this.progressColor, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(ingredient.toUpperCase(), style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 10,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5)),color: Colors.black12,
                ),
              ),
               Container(
                height: 10,
                width: width * progress,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5)),
                    color: progressColor,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Text("${leftAmount} gram "),
        ],
      ),
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {

  final double height, width, progress;

  const _RadialProgress({Key? key, required this.height, required this.width, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: 0.7,

        ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: "1061", style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF200087),
                ),),
                TextSpan(text: "\n"),
                TextSpan(text: "kcal", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF200087),
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
    ..strokeWidth = 10
      ..color = Color(0XFF200087)
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
  
  final Meal meal;

  const _MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 10,),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Image.asset(
                meal.imagePath,
                width: 150,
                fit: BoxFit.fill,
                ),
              ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      ),
                    Text(
                      "${meal.kiloCalories} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.black,
                          size: 15,
                          ),
                        Text("${meal.timeTaken} min"),
                      ],
                    ),
                    SizedBox(
                      height: 16
                    )
                  ],
                ),
              )
              ),
          ],
        ),
      ),
    );
  }
}

class _WaterProgressBar extends StatelessWidget {

   double percent,height, width;

   _WaterProgressBar({Key? key, required this.height, required this.width, required this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
              children: <Widget>[
                RoundedProgressBar(
                    childLeft: Text("$percent%",
                    style: TextStyle(color: Colors.white),),
                    percent: percent,
                    theme: RoundedProgressBarTheme.blue,),
                ],
          );
  }
}
