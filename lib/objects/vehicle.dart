import 'package:flutter/foundation.dart';
import 'package:waterbills/utils.dart';

import 'wbobject.dart';

class Vehicles extends WBCollection<Vehicle> {
  Vehicles._() {
    collectionName = "vehicles";
    ref = fireInst.collection(collectionName!).withConverter<Vehicle>(
        fromFirestore: (snap, _) => Vehicle.fromJson(snap.data()!),
        toFirestore: (vehicle, _) => vehicle.toJson());
  }

  static Vehicles instance = Vehicles._();

  factory Vehicles() {
    if (instance.collectionName == '') {
      instance = Vehicles._();
    }
    return instance;
  }

  @override
  getCollection() async {
    await super.getCollection();
    list.sort((a, b) => (b.to! <= a.to!) ? 1 : -1);
  }
}

class Vehicle extends WBObject {
  String? id, name;
  int? from, to;

  Vehicle({
    @required this.id,
    @required this.name,
    @required this.from,
    @required this.to,
  });

  factory Vehicle.fromJson(Map<dynamic, dynamic> i) {
    return Vehicle(
      id: i["id"] ?? Utils.generateId("vehicle_"),
      name: i["name"] ?? "",
      from: i["from"] ?? 0,
      to: i["to"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "from": from,
      "to": to,
    };
  }
}
