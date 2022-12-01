import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_a_car_design_four/pages/add_car_page.dart';
import 'package:rent_a_car_design_four/pages/car_details_page.dart';
import 'package:rent_a_car_design_four/pages/car_list_for_user.dart';
import 'package:rent_a_car_design_four/pages/car_list_page.dart';
import 'package:rent_a_car_design_four/pages/home_page.dart';
import 'package:rent_a_car_design_four/pages/launcher_page.dart';
import 'package:rent_a_car_design_four/pages/log_in_page.dart';
import 'package:rent_a_car_design_four/providers/car_provider.dart';
import 'package:rent_a_car_design_four/providers/user_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CarProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        CarListPage.routeName: (context) => const CarListPage(),
        CarListForUser.routeName: (context) => const CarListForUser(),
        AddCarPage.routeName: (context) => const AddCarPage(),
        CarDetailsPage.routeName: (context) => const CarDetailsPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        LauncherPage.routeName: (context) => const LauncherPage(),
      },
    );
  }
}
