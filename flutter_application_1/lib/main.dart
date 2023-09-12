import 'dart:io';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/bloc_obsever.dart';
import 'package:flutter_application_1/data/data_provider/resourses.dart';
import 'package:flutter_application_1/data/data_provider/sqlite_db.dart';
import 'package:flutter_application_1/data/models/location.dart';
import 'package:flutter_application_1/data/repositories/weather_repo.dart';
import 'package:flutter_application_1/logic/internet/internet_bloc.dart';
import 'package:flutter_application_1/logic/list_interested_city.dart/interested_cities_bloc.dart';
import 'package:flutter_application_1/logic/list_weather/list_weather_bloc.dart';
import 'package:flutter_application_1/logic/weather/weather_bloc.dart';
import 'package:flutter_application_1/presentation/drawer/drawer.dart';
import 'package:flutter_application_1/presentation/pages/main_widget.dart';
import 'package:flutter_application_1/presentation/pages/splash.dart';
import 'package:flutter_application_1/presentation/pages/search_page.dart';
import 'package:flutter_application_1/presentation/widgets/current_weather_card.dart';
import 'package:flutter_application_1/presentation/widgets/forecast_weather_widget.dart';
import 'package:flutter_application_1/presentation/widgets/weather_by_hours.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding();
  final prefs = await SharedPreferences.getInstance();
  bool show = prefs.getBool("IS_ON_BOARDING") ?? false;
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  BlocObserver observer = AppBlocObsever();
  print("Main function here");
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SPlashScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Connectivity connectivity = Connectivity();
  final WeatherRepository weatherRepo = WeatherRepository();
  final SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
  late String? city;
  double? longitude;
  double? latitude;
  Future<Position>? _position;
  @override
  void initState() {
    // if (kIsWeb) {
    //   window.addEventListener('focus', onFocus);
    //   window.addEventListener('blur', onBlur);
    // }
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // void onFocus(Event e) {
  //   didChangeAppLifecycleState(AppLifecycleState.resumed);
  // }

  // void onBlur(Event e) {
  //   didChangeAppLifecycleState(AppLifecycleState.paused);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('app resumed');
        break;
      case AppLifecycleState.paused:
        print('app paused');
        break;
      case AppLifecycleState.inactive:
        print('app inactive');
        break;
      case AppLifecycleState.detached:
      default:
        print('app detached');
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => InternetBloc(connectivity: connectivity),
        child: MaterialApp(home: MyPage()));
  }
}

class MyPage extends StatelessWidget {
  MyPage({super.key});
  // final String city;
  final WeatherRepository weatherRepo = WeatherRepository();
  final SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetBloc, InternetState>(
      builder: (context, state) {
        if (state is InternetConnected) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InterestedCitiesBloc(
                    sqLiteDatabase: sqLiteDatabase,
                    weatherRepository: weatherRepo),
              ),
              BlocProvider(
                create: (context) =>
                    ListWeatherBloc(weatherRepository: weatherRepo),
              ),
              // BlocProvider(
              //   create: (context) => WeatherBloc(weatherRepo: weatherRepo),
              // )
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MyHomePage(weatherRepo: weatherRepo),
            ),
          );
        } else {
          print("Check internet nha man");
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wifi_off),
                SizedBox(
                  height: 5,
                ),
                Text("Weather Unavailable"),
                SizedBox(
                  height: 5,
                ),
                Text(
                    "The app isn't connected yo the internet. To view the weather in the app, check your connection, and then try again",
                    overflow: TextOverflow.clip),
              ],
            )
                //  Card(
                //   elevation: 3,
                //   color: Colors.greenAccent,
                //   child: Text(
                //     "No internet connection",
                //     style: GoogleFonts.abhayaLibre(
                //         textStyle: Theme.of(context).textTheme.displayMedium),
                //   ),
                // ),
                ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.weatherRepo});
  final WeatherRepository weatherRepo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherRepository weatherRepo = WeatherRepository();
  final SQLiteDatabase sqLiteDatabase = SQLiteDatabase();
  String? city;
  bool isAccess = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    await _requestLocationPermission();
    if (isAccess) {
      getPosition(context);
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        isAccess = true;
      });
    } else if (status.isDenied) {
    } else {}
  }

  Future getPosition(BuildContext context) async {
    // final context = this.context;
    final position = await Resource.getCurrentLocation();
    final longitudePosition = position.longitude;
    final latitudePosition = position.latitude;

    print("longitude: $longitudePosition");
    print("latitude: $latitudePosition");
    final weatherInfor = await weatherRepo.getWeatherInforForLongLat(
        longitudePosition, latitudePosition);
    String cityName = weatherInfor!.location!.name!;
    String? cityData = await Resource.getCityFromCoordinates(
        latitudePosition, longitudePosition);
    setState(() {
      city = cityName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(currentLocation: city, isAccess: isAccess),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.location_on)),
            isAccess
                ? (city != null
                    ? Text(city ?? "")
                    : const CircularProgressIndicator())
                : const Text("No location"),
          ],
        ),
      ),
      body: isAccess
          ? (city != null
              ? MainWidget(weatherRepo: widget.weatherRepo, city: city)
              : const Center(
                  child: CircularProgressIndicator(),
                ))
          : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No access to current location"),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          await _initLocation();
                        },
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                        ),
                        label: const Text("Get current location"))
                  ]),
            ),
    );
  }
}
