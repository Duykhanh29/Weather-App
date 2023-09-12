import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/presentation/pages/onboarding/first_onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPlashScreen extends StatefulWidget {
  const SPlashScreen({super.key});

  @override
  State<SPlashScreen> createState() => _SPlashScreenState();
}

class _SPlashScreenState extends State<SPlashScreen> {
  late SharedPreferences prefs;
  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences().then((value) {
      bool? isShow = prefs.getBool("IS_ON_BOARDING") ?? false;
      Timer(const Duration(seconds: 6), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    isShow ? const MyApp() : const Onboarding()));
      });
    });

    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => const Onboarding()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // buy (0:2)
          // padding:  EdgeInsets.fromLTRB(74*fem, 203*fem, 86*fem, 295*fem),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            gradient: LinearGradient(
              begin: Alignment(-0.508, -1.655),
              end: Alignment(-2.653, 0.387),
              colors: <Color>[Color(0xfff2f4f7), Color(0xffbcc8d6)],
              stops: <double>[0, 1],
            ),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // groupoWF (0:4)
                // margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 49*fem),
                width: 100,
                height: 100,
                child: Image.asset(
                  "assets/images/weather_logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                // weatherforecast6kF (0:20)
                margin: const EdgeInsets.all(5),
                // constraints:  BoxConstraints (
                // maxWidth:  176*fem,
                // ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.abyssinicaSil(),
                    children: [
                      TextSpan(
                          text: 'Weather',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(text: ' ', style: GoogleFonts.aBeeZee()),
                    ],
                  ),
                ),
              ),
              Text('Forecast', style: GoogleFonts.adamina(fontSize: 15)),
              // const Spacer(),
              // Text("it is quite strange")
            ],
          ),
        ),
      ),
    );
  }
}
