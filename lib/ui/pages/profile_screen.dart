import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';
import '../../service/add_meal_service.dart';

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
            height: 300,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 30, left: 30, right: 16, bottom: 10),
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
                      ),),
                    ),
                    SizedBox(height: 10),
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
                              userId: "yunus@gmail.com",
                              progressColor: Colors.green,
                              width: width * 0.28,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            _IngredientProgress(
                              ingredient: "Karbonhidrat",
                              userId: "yunus@gmail.com", 
                              progressColor: Colors.red,
                              width: width * 0.28,
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            _IngredientProgress(
                              ingredient: "Yağ", 
                              userId: "yunus@gmail.com",
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
              top:  300,
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
                            top: 10,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:50),
                          child: MaterialButton(
                            onPressed: _showDatePicker,
                            child: Padding(padding: EdgeInsets.all(0),
                            child: Text(
                              "Tarih Seçin",
                            ),
                            ),
                            )
                        ),
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

class _IngredientProgress extends StatefulWidget {
  final String ingredient;
  final String userId;
  final double width;
  final Color progressColor;

  const _IngredientProgress({
    Key? key,
    required this.ingredient,
    required this.userId,
    required this.width,
    required this.progressColor,
  }) : super(key: key);

  @override
  _IngredientProgressState createState() => _IngredientProgressState();
}

class _IngredientProgressState extends State<_IngredientProgress> {
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('addMeals')
          .where('userId', isEqualTo: widget.userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Veriler alınırken bir hata oluştu.');
        }

        if (snapshot.hasData) {
          final meals = snapshot.data!.docs;
          totalAmount = 0;

          for (final meal in meals) {
            final data = meal.data() as Map<String, dynamic>;
            final ingredientAmount = data[widget.ingredient] as int?;
            if (ingredientAmount != null) {
              totalAmount += ingredientAmount;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.ingredient.toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
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
                        width: widget.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black12,
                        ),
                      ),
                      Container(
                        height: 10,
                        width: widget.width * (totalAmount / 100),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: widget.progressColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Text("$totalAmount gram"),
                ],
              ),
            ],
          );
        }

        return Container();
      },
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
        progress: 0.65,

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
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5563C1),
                ),),
                TextSpan(text: "\n"),
                TextSpan(text: "kcal", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5563C1),
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
      ..color = Color(0xFF5563C1)
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
                                IconButton(onPressed: null, icon: Icon(Icons.delete,color: Colors.white,size: 35,)),  
                                
                                CircleAvatar(backgroundImage: NetworkImage(mealsData['imageUrl']),radius: 55,),
                                Text(mealsData["mealName"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                Text("Kalori:   " + mealsData["calorie"] + "kcal"),
                                Text("Karbonhidrat:" + mealsData["carbohydrate"] + "g"),
                                Text("Protein:  " + mealsData["protein"] + "g"),
                                Text("Yağ:  " + mealsData["fat"] + "g"),
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
