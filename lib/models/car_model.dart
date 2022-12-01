const String tblCar = "tbl_car";
const String tblCarColId = "id";
const String tblCarColCarModel = "carModel";
const String tblCarColCarCategory = "carCategory";
const String tblCarColCarImage = "carImage";
const String tblCarColCarFare = "carFare";
const String tblCarColDriverName = "driverName";
const String tblCarColDriverImage = "driverImage";
const String tblCarColDriverAge = "driverAge";
const String tblCarColDriverAddress = "driverAddress";
const String tblCarColDriverPhone = "driverPhone";
//const String tblCarColDriverHasLicence = "hasLicence";

class CarModel {
  int? id;
  String carModel;
  String carCategory;
  String carImage;
  int carFare;
  String driverName;
  String driverImage;
  int driverAge;
  String driverAddress;
  int driverPhone;
  // bool hasLicence = true;

  CarModel({
    this.id,
    required this.carModel,
    required this.carCategory,
    required this.carImage,
    required this.carFare,
    required this.driverName,
    required this.driverImage,
    required this.driverAge,
    required this.driverAddress,
    required this.driverPhone,
    // required this.hasLicence
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCarColCarModel: carModel,
      tblCarColCarCategory: carCategory,
      tblCarColCarImage: carImage,
      tblCarColCarFare: carFare,
      tblCarColDriverName: driverName,
      tblCarColDriverImage: driverImage,
      tblCarColDriverAge: driverAge,
      tblCarColDriverAddress: driverAddress,
      tblCarColDriverPhone: driverPhone,
      //tblCarColDriverHasLicence : hasLicence ? 1:0,
    };
    if (id != null) {
      map[tblCarColId] = id;
    }
    return map;
  }

  factory CarModel.fromMap(Map<String, dynamic> map) => CarModel(
        id: map[tblCarColId],
        carModel: map[tblCarColCarModel],
        carCategory: map[tblCarColCarCategory],
        carImage: map[tblCarColCarImage],
        carFare: map[tblCarColCarFare],
        driverName: map[tblCarColDriverName],
        driverImage: map[tblCarColDriverImage],
        driverAge: map[tblCarColDriverAge],
        driverAddress: map[tblCarColDriverAddress],
        driverPhone: map[tblCarColDriverPhone],
        //hasLicence: map[tblCarColDriverHasLicence],
      );
}
