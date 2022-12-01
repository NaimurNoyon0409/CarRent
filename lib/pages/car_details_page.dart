import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_a_car_design_four/models/car_model.dart';
import 'package:rent_a_car_design_four/pages/add_car_page.dart';
import 'package:rent_a_car_design_four/providers/car_provider.dart';

class CarDetailsPage extends StatefulWidget {
  static const String routeName = '/car_details';
  const CarDetailsPage({Key? key}) : super(key: key);

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late int id;
  late String model;
  late CarProvider carProvider;

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    carProvider = Provider.of<CarProvider>(context, listen: false);
    id = argList[0];
    model = argList[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(model),
        actions: [
          IconButton(
              onPressed: () {
                _deleteCar(context, id, carProvider);
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCarPage.routeName,
                        arguments: id)
                    .then((value) {
                  setState(() {
                    model = value as String;
                  });
                });
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Center(
        child: FutureBuilder<CarModel>(
          future: carProvider.getCarById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final car = snapshot.data!;
              return ListView(
                children: [
                  Container(color: Colors.purple.shade200,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Car Details',style: TextStyle(fontSize: 22,color: Colors.white),),
                      )),
                  Image.file(
                    File(car.carImage),
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Car Model : ',style: TextStyle(color: Colors.purple),),
                          Text(car.carModel),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Car Brand : ',style: TextStyle(color: Colors.purple),),
                          Text(car.carCategory),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Car Fare : ',style: TextStyle(color: Colors.purple),),
                          Text(car.carFare.toString()),
                          Text('/day')
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(color: Colors.purple.shade200,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Driver Details',style: TextStyle(fontSize: 22,color: Colors.white),),
                      )),
                  SizedBox(height: 2,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.file(
                          File(car.driverImage),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Driver Name : ',style: TextStyle(color: Colors.purple),),
                                Text(car.driverName),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Driver Age : ',style: TextStyle(color: Colors.purple),),
                                Text(car.driverAge.toString()),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Driver Address : ',style: TextStyle(color: Colors.purple),),
                                Text(car.driverAddress),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Driver Phone : ',style: TextStyle(color: Colors.purple),),
                                Text(car.driverPhone.toString()),
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                  )

                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Failed to load data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _deleteCar(BuildContext context, int id, CarProvider carProvider) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete This Movie'),
              content: Text('Are you sure to delete this movie'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      carProvider.deleteCar(id).then((value) {
                        Navigator.pop(context);
                        carProvider.getAllCars();
                      });
                    },
                    child: Text('Yes'))
              ],
            ));
  }
}
