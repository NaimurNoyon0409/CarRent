import 'package:flutter/material.dart';
import 'package:rent_a_car_design_four/pages/car_list_page.dart';
import 'package:rent_a_car_design_four/pages/home_page.dart';
import 'package:rent_a_car_design_four/pages/log_in_page.dart';
import 'package:rent_a_car_design_four/utils/helper_function.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    redirectUser();
    super.initState();
  }

  Future<void> redirectUser() async {
    if (await getLoginStatus()) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
