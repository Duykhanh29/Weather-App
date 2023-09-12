import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/onboard.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/presentation/pages/onboarding/second_onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController pageController;
  late SharedPreferences sharedPreferences;
  Future<void> initPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void registerOnboarding() {
    sharedPreferences.setBool("IS_ON_BOARDING", true);
  }

  @override
  void initState() {
    // TODO: implement initState

    pageController = PageController(initialPage: 0);
    initPreference().then((value) {
      registerOnboarding();
    });
    super.initState();
  }

  int pageIndex = 0;

  final listData = [
    Onboard(
        image: "assets/images/rainning.png",
        subtitle: "Get in - depth weather information",
        title: "Weather Around the World"),
    Onboard(
        image: "assets/images/sunny.png",
        subtitle: "Watch the progress of the precipitation to stay informed",
        title: "Real-Time Weather Map"),
    Onboard(
        image: "assets/images/moon_star.png",
        subtitle: "Watch the progress of the precipitation to stay informed",
        title: "Detailed Hourly Forecast"),
    Onboard(
        image: "assets/images/cloud_sun.png",
        subtitle: "Get in - depth weather information",
        title: "Weather Around the World")
  ];
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.pink.shade200;
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: listData.length,
              scrollBehavior: ScrollBehavior(),
              onPageChanged: (value) {
                if (value <= listData.length - 1) {
                  setState(() {
                    pageIndex = value;
                  });
                }
              },
              itemBuilder: (context, index) {
                return SecondOnBoarding(
                    onboard: listData[index], backgroundColor: backgroundColor);
              },
              controller: pageController,
            ),
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    listData.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: DotIndicator(isActive: index == pageIndex),
                        )),
                const SizedBox(
                  width: 70,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    if (pageIndex == listData.length - 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyApp()));
                    } else {
                      // pageController.animateToPage(pageIndex,
                      //     duration: const Duration(microseconds: 100),
                      //     curve: Curves.linear);
                      pageController.nextPage(
                          duration: const Duration(microseconds: 100),
                          curve: Curves.linear);
                    }
                  },
                  label:
                      Text(pageIndex == listData.length - 1 ? "Done" : "Next"),
                  icon: pageIndex == listData.length - 1
                      ? const Icon(Icons.forward)
                      : const Icon(Icons.navigate_next),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  DotIndicator({super.key, this.isActive = false});
  bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      height: isActive ? 7 : 4,
      width: 23,
      decoration: BoxDecoration(
          color: isActive ? Colors.blueAccent : Colors.orangeAccent,
          borderRadius: BorderRadius.circular(6)),
    );
  }
}
