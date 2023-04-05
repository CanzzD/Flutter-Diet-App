import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today =DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFF200087),
      body: SingleChildScrollView(
        child: Padding(
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
                    subtitle: Text("Water-Tracker-Demo",
                        style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.white, 
                      ),
                    ),
                    trailing: Column(
                      children: <Widget>[
                      ],
                    ),
              ),
            ],
        ),
       ),
      ),
    );
  }
}