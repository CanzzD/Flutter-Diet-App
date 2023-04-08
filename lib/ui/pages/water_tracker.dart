import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';


class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today =DateTime.now();

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        children: 
         [Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.close, 
                      color: Colors.white,
                      size: 40,
                    ), onPressed: () {  
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  title: Text("${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)} ",
                          style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white, 
                        ),
                      ),
                      subtitle: Text(
                        "Su İzleyici",
                          style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.white, 
                        ),
                      ),
                ),

                SizedBox(height: 40),
                //WATER PROGRESS GAME
                _WaterProgressBar1(),
                Column(
                ),
          ],
         ),
         ),
       ],
      ),
    );
  }
}


class _WaterProgressBar1 extends StatefulWidget {
  const _WaterProgressBar1({Key? key}) : super(key: key);

  @override
  State<_WaterProgressBar1> createState() => __WaterProgressBar1State();
}

class __WaterProgressBar1State extends State<_WaterProgressBar1> {
  double percent = 0 ;
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Column(
              children: <Widget>[
                SizedBox(height: 10,),

                Text(
                  "Hedefini Tamamlamak İçin Barı Doldurmalısın",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 60,),

                RoundedProgressBar(
                    childLeft: Text("                Günlük Hedefiniz 2500mL(2.5L)",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    percent: percent,
                    theme: RoundedProgressBarTheme.blue),
                    SizedBox(height: 40,),


                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                              Colors.blue.shade800,
                              Color.fromARGB(255, 192, 21, 126),
                            ],
                      )
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "Bardak Su",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:130.0),
                                child: TextButton(
                                onPressed: () {setState(() {
                                  percent = percent + 10;
                                });}, 
                                child: Text(
                                  "250mL(0.25L)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  ))
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:35.0),
                            child: IconButton(icon: Icon(Icons.remove),iconSize: 50,color: Colors.white, onPressed: () {setState(() {
                                            percent = percent - 10;
                                          });},),
                          ), 
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                              Colors.blue.shade800,
                              Color.fromARGB(255, 192, 21, 126),
                            ],
                      )
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 17),
                      child: Text(
                        "Şişe Su",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:180.0),
                                child: TextButton(
                                onPressed: () {setState(() {
                                  percent = percent + 20;
                                });}, 
                                child: Text(
                                  "200mL(0.5L)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  ))
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:0.0),
                            child: IconButton(icon: Icon(Icons.remove),iconSize: 50,color: Colors.white, onPressed: () {setState(() {
                                            percent = percent - 20;
                                          });},),
                          ), 
                        ],
                      ),
                    ],
                  ),
                ),
                ],
          );
  }
}
