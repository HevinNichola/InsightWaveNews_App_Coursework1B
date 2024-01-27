import'package:flutter/material.dart';

import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child : ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child : Image.asset(
                    "images/landImage.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              RichText(
                text : const TextSpan(
                  text: "InsightWave",
                  style: TextStyle(color: Colors.black87,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: "News",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17,),

              const Text("Empower with Information Anywhere",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,

                ),
              ),
              const SizedBox(height: 20.0),
              const Text("Unleash a personlized realm of breaking news, trending news, transforming information into empowerment ",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500
                  )
              ),
              const SizedBox(height: 40.0),

              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                },
                child :SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 5.0,

                    child : Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.red, borderRadius: BorderRadius.circular(30)),
                      child:const Center(
                        child: Text("Get Started",
                          style: TextStyle(color: Colors.white,
                              fontSize:17.0,
                              fontWeight : FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
