import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: About(),
    debugShowCheckedModeBanner: false,
  ));
}

//stless
class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/Assets/images/BG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 30.0, left: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage("lib/Assets/images/MY PHOTO.jpg"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Mehedi Hasan",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontFamily: "Roboto"),
                      ),
                      Text(
                        "Competetive Programmer",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(179, 255, 255, 255),
                            fontFamily: "Robotor"),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.school,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "B.sc in CSE",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontFamily: "Robotor"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.note_add_rounded,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Android Portfolio App",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontFamily: "Robotor"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Dhaka, Savar",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontFamily: "Robotor"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "mehedi15-14721@diu.edu.bd",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontFamily: "Robotor"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 30,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "+8801782391049",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontFamily: "Robotor"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "I'm Mehedi Hasan Naim, a dedicated Competetive programmer & Application devloper. Currently doing B.Sc. in Computer Science and Engineering at Daffodil International University. I have experiance of being Associate Judging Director in Unlock the Algorithm Contest as well as I was champion in Takeoff & Unlock the Algorithm Programming Contest organized by DIU",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 250, 250, 250),
                      fontFamily: "Robotor"),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Created By MH Naim",
                style: TextStyle(
                    fontSize: 13, color: Colors.teal, fontFamily: "Robotor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
