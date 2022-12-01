import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import 'car_details_page.dart';

class CarListForUser extends StatefulWidget {
  static const String routeName = '/car_list_user';
  const CarListForUser({Key? key}) : super(key: key);

  @override
  State<CarListForUser> createState() => _CarListForUserState();
}

class _CarListForUserState extends State<CarListForUser> {
  String? root;
  @override
  void didChangeDependencies() {
    Provider.of<CarProvider>(context, listen: false).getAllCars();
    root = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title:  Text(root.toString()),
      ),
      body: Consumer<CarProvider>(builder: (context, provider, child) {
        provider.getCarByCategory(root.toString());
        return ListView.builder(
          itemCount: provider.carListCategory.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.pushNamed(
                  context, CarDetailsPage.routeName, arguments: [
                provider.carListCategory[index].id,
                provider.carListCategory[index].carModel
              ]),
              child: Card(
                color: Colors.purple.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                children: [
                  Image.file(
                    File(provider.carListCategory[index].carImage),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10,),
                  Text(provider.carListCategory[index].carModel),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Fare - '),
                      Text(provider.carListCategory[index].driverAge.toString(),style: TextStyle(fontSize: 20),),
                      Text('/day'),
                    ],
                  ),
                ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

