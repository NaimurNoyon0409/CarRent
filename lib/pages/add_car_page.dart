import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rent_a_car_design_four/models/car_model.dart';
import 'package:rent_a_car_design_four/utils/constant.dart';
import 'package:rent_a_car_design_four/utils/helper_function.dart';

import '../models/car_model.dart';
import '../providers/car_provider.dart';
import '../utils/constant.dart';
import '../utils/helper_function.dart';

class AddCarPage extends StatefulWidget {
  static const String routeName = '/add_car';
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  late CarProvider carProvider;
  final carModelController = TextEditingController();
  final carFareController = TextEditingController();
  final driverNameController = TextEditingController();
  final driverAgeController = TextEditingController();
  final driverAddressController = TextEditingController();
  final driverPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCarCategory;
  String? selectedCarRoot;
  String? driverImagePath;
  String? carImagePath;
  int? id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int?;
    carProvider = Provider.of<CarProvider>(context, listen: false);
    if (id != null) {
      final car = carProvider.getItem(id!);
      _setData(car);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    carModelController.dispose();
    carFareController.dispose();
    driverNameController.dispose();
    driverAgeController.dispose();
    driverAddressController.dispose();
    driverPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(id == null ? 'Add New Car' : 'Update Car Info'),
        actions: [
          IconButton(
              onPressed: () {
                saveCar();
              },
              icon: Icon(id == null ? Icons.save : Icons.update))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(color: Colors.purple.shade200,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Enter Car Info:',style: TextStyle(fontSize: 22,color: Colors.white),),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                carImagePath == null ?
                const Icon(
                  Icons.movie,
                  size: 100,
                )
                    : Image.file(
                  File(carImagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                TextButton(
                  onPressed: getCarImage,
                  child: const Text("Select From Gallery"),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                style: TextStyle(height: 0.5),
                controller: carModelController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter Car Model",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field must not be empty";
                  }
                },
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),              child: DropdownButtonFormField<String>(
                style: TextStyle(fontSize: 12,height: 0.5),
                hint: const Text('Select a Car Type'),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                items: carCategory
                    .map((e) => DropdownMenuItem(value: e, child: Text(e!)))
                    .toList(),
                value: selectedCarCategory,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field must not be empty";
                  }
                },
                onChanged: (value) {
                  setState(() {
                    selectedCarCategory = value;
                  });
                }),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                style: TextStyle(fontSize: 12,height: 0.5),
                keyboardType: TextInputType.number,
                controller: carFareController,
                decoration: InputDecoration(
                  hintText: "Enter Car Fare",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field must not be empty";
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(color: Colors.purple.shade200,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Enter Driver Info:',style: TextStyle(fontSize: 22,color: Colors.white),),
                )),
            SizedBox(height: 15,),

            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                style: TextStyle(height: 0.5),
                controller: driverNameController,
                decoration: InputDecoration(
                  hintText: "Enter Driver Name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field must not be empty";
                  }
                },
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                style: TextStyle(fontSize: 12,height: 0.5),
                keyboardType: TextInputType.number,
                controller: driverAgeController,
                decoration: InputDecoration(
                  hintText: "Enter Driver Age",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field must not be empty";
                  }
                },
              ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),              child: TextFormField(
              style: TextStyle(fontSize: 12,height: 0.5),
              controller: driverAddressController,
              decoration: InputDecoration(
                hintText: "Enter Driver Address",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
              },
            ),
            ),
            SizedBox(height: 2,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),              child: TextFormField(
              style: TextStyle(fontSize: 12,height: 0.5),
              keyboardType: TextInputType.number,
              controller: driverPhoneController,
              decoration: InputDecoration(
                hintText: "Enter Driver Phone No",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field must not be empty";
                }
              },
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                driverImagePath == null
                    ? const Icon(
                  Icons.movie,
                  size: 100,
                )
                    : Image.file(
                  File(driverImagePath!),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                TextButton.icon(
                  onPressed: getDriverImage,
                  icon: const Icon(Icons.photo),
                  label: const Text("Select From Gallery"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getDriverImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        driverImagePath = file.path;
      });
    }
  }
  void getCarImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        carImagePath = file.path;
      });
    }
  }

  void saveCar() {
    if (driverImagePath == null) {
      showMsg(context, "Please Select an Image");
      return;
    }
    if (_formKey.currentState!.validate()) {
      final car = CarModel(
        carImage: carImagePath!,
        carModel: carModelController.text,
        carCategory: selectedCarCategory!,
        carFare: int.parse(carFareController.text),
        driverName: driverNameController.text,
        driverImage: driverImagePath!,
        driverAge: int.parse(driverAgeController.text),
        driverAddress: driverAddressController.text,
        driverPhone: int.parse(driverPhoneController.text),
        //hasLicence: true,
      );

      if (id != null) {
        car.id = id;
        carProvider.updateCar(car).then((value) {
          carProvider.getAllCars();
          Navigator.pop(context, car.carModel);
        }).catchError((error) {
          print(error.toString());
        });
      } else {
        carProvider.insertCar(car).then((value) {
          carProvider.getAllCars();
          Navigator.pop(context);
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }

  void _setData(CarModel car) {
    carModelController.text = car.carModel;
    carFareController.text = car.carFare.toString();
    driverNameController.text = car.driverName;
    driverAgeController.text = car.driverAge.toString();
    driverAddressController.text = car.driverAddress;
    driverPhoneController.text = car.driverPhone.toString();
    selectedCarCategory = car.carCategory;
    driverImagePath = car.driverImage;
    carImagePath = car.carImage;
  }


}
