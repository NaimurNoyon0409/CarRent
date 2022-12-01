import 'package:flutter/material.dart';
import 'package:rent_a_car_design_four/database/db_helper.dart';

import '../models/car_model.dart';

class CarProvider extends ChangeNotifier {
  List<CarModel> carList = [];

  Future<int> insertCar(CarModel carModel) => DbHelper.insertCar(carModel);

  void getAllCars() async {
    carList = await DbHelper.getAllCars();
    notifyListeners();
  }

  Future<CarModel> getCarById(int id) => DbHelper.getCarById(id);

  Future<int> deleteCar(int id) => DbHelper.deleteCar(id);

  CarModel getItem(int id) {
    return carList.firstWhere((element) => element.id == id);
  }

  Future<int> updateCar(CarModel carModel) => DbHelper.updateCar(carModel);


  List<CarModel> carListCategory = [];

  Future<void> getCarByCategory(String category) async {
    carListCategory = await DbHelper.getCarByCategory(category);
    notifyListeners();
  }
}
