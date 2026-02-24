import 'package:flutter/foundation.dart';
import 'package:waterbills/utils.dart';

import 'wbobject.dart';

class Companies extends WBCollection<Company> {
  Companies._() {
    collectionName = "companies";
    ref = fireInst.collection(collectionName!).withConverter<Company>(
        fromFirestore: (snap, _) => Company.fromJson(snap.data()!),
        toFirestore: (company, _) => company!.toJson());
  }

  static Companies instance = Companies._();

  factory Companies() {
    if (instance.collectionName == '') {
      instance = Companies._();
    }
    return instance;
  }
}

class Company extends WBObject {
  String? id, name, address, gstNumber;
  List<String>? mailTo;
  int productsCount = 0, invoicesCount = 0, dcsCount = 0;

  Company(
      {@required this.id,
      @required this.name,
      @required this.address,
      @required this.gstNumber,
      @required this.mailTo});

  factory Company.fromJson(Map<dynamic, dynamic> i) {
    return Company(
      id: i["id"] ?? Utils.generateId("company_"),
      name: i["name"] ?? "",
      address: i["address"] ?? "",
      gstNumber: i["gst_no"] ?? "",
      mailTo: i["mail_to"] != null
          ? List<String>.generate(
              i["mail_to"].length, (index) => i["mail_to"][index])
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "address": address,
      "gst_no": gstNumber,
      "mail_to": mailTo,
    };
  }
}
