import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/data/models/onboard.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondOnBoarding extends StatelessWidget {
  SecondOnBoarding(
      {super.key, required this.onboard, required this.backgroundColor});
  Onboard onboard;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      // decoration: const BoxDecoration(
      //     // color: Color.fromARGB(255, 255, 255, 255),
      //     // gradient: LinearGradient(
      //     //   begin: Alignment(-0.896, -1),
      //     //   end: Alignment(-0.896, 0.791),
      //     //   colors: <Color>[Color(0xff484b5b), Color(0xff2c2d35)],
      //     //   stops: <double>[0, 1],
      //     // ),
      //     ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(40),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(),
                color: Color.fromARGB(255, 206, 238, 251)),
            child: SizedBox(
              height: 100,
              width: 100,
              child: FittedBox(
                child: Image.asset(
                  onboard.image!,
                  // width: 40,
                  // height: 70,
                ),
              ),
            ),
            // ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  color: Colors.greenAccent.shade100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    onboard.title!,
                    style: GoogleFonts.alatsi(fontSize: 29),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(onboard.subtitle!,
                      style: GoogleFonts.cantarell(fontSize: 18)),
                  // style: GoogleFonts.cabinSketch(fontSize: 20))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
