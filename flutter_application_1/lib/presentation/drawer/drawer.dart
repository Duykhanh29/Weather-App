import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key, required this.currentLocation, required this.isAccess});
  String? currentLocation;
  bool isAccess;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueAccent.shade100,
      elevation: 3,
      width: 280,
      child: Padding(
        padding: const EdgeInsets.only(top: 85, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Location",
              style: TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 20,
                ),
                if (isAccess && currentLocation != null) ...{
                  Text(
                    currentLocation!,
                    style: const TextStyle(fontSize: 20),
                  ),
                } else if (isAccess && currentLocation == null) ...{
                  const CircularProgressIndicator()
                } else ...{
                  const Text("No location")
                }
              ],
            ),
            const Spacer(),
            const Padding(
                padding: EdgeInsets.only(left: 25), child: Text("Tools")),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.feedback,
                    size: 25,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Send feedback",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Rate th app",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
