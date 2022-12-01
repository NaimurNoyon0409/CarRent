import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_a_car_design_four/pages/add_car_page.dart';
import 'package:rent_a_car_design_four/pages/car_details_page.dart';
import 'package:rent_a_car_design_four/pages/launcher_page.dart';
import 'package:rent_a_car_design_four/providers/car_provider.dart';
import 'package:rent_a_car_design_four/utils/helper_function.dart';

class CarListPage extends StatefulWidget {
  static const String routeName = '/car_list';
  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  @override
  void didChangeDependencies() {
    Provider.of<CarProvider>(context, listen: false).getAllCars();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.pushNamed(context, AddCarPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("All Car List"),
      ),
      body: Consumer<CarProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.carList.length,
          itemBuilder: (context, index) {
            final car = provider.carList[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(
                  context, CarDetailsPage.routeName,
                  arguments: [car.id, car.carModel]),
              leading: Image.file(
                File(car.carImage),
                height: 200,
                width: 100,
                fit: BoxFit.cover,
              ),
              title: Text(car.carModel,style: TextStyle(color: Colors.purple),),
              subtitle: Text(car.carCategory),
            );
          },
        ),
      ),
    );
  }
}
