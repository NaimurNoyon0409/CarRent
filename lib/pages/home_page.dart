import 'package:flutter/material.dart';
import 'package:rent_a_car_design_four/pages/car_list_page.dart';

import '../utils/constant.dart';
import '../utils/helper_function.dart';
import 'car_list_for_user.dart';
import 'launcher_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCarCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CarListPage.routeName);
            },
            icon: const Icon(Icons.admin_panel_settings),
          ),
          IconButton(
              onPressed: (){
                setLoginStatus(false).then((value) {
                  Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body:Column(
        children: [
          Image.asset('images/crh.png',height: 300,width: double.infinity,fit: BoxFit.cover,),
          Text('Choose Your Favorite Car Brand',style: TextStyle(fontSize: 20,color: Colors.purple),),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: DropdownButtonFormField<String>(
                hint: const Text('Select a Car Type'),
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
                    Navigator.pushNamed(context, CarListForUser.routeName,
                        arguments: selectedCarCategory);
                  });
                }),
          ),
          const SizedBox(height: 50,),
          Text('Top Brands',style: TextStyle(fontSize: 20,color: Colors.purple),),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/toyota.png',height: 100,width: 100,),
                      Text('Toyota',style: TextStyle(color: Colors.purple),),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/tesla.png',height: 100,width: 100,),
                      Text('Tesla',style: TextStyle(color: Colors.purple),),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/bmw.png',height: 100,width: 100,),
                      Text('BMW',style: TextStyle(color: Colors.purple),),
                      SizedBox(height: 15,)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/audi.png',height: 100,width: 100,),
                      const Text('Audi',style: TextStyle(color: Colors.purple),),
                      const SizedBox(height: 15,)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/volkswagen.png',height: 100,width: 100,),
                      const Text('Volkswagen',style: TextStyle(color: Colors.purple),),
                      const SizedBox(height: 15,)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )

    );
  }
}
