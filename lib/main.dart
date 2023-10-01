

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/List_Page.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: blue_white_widget(),
      ),
    );
  }
}

class blue_white_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigoAccent, Colors.white],
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            children: [
              Lottie.asset(
                'images/Animation - 1695928124871.json',
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Text(
                "Mini to do list",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                "My first task in the CodSoft internship",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.indigoAccent),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => List_page()),
                          );
                        },
                        icon: Text(
                          "Let's Start",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
