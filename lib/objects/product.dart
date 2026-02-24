import 'package:flutter/foundation.dart';

import '../utils.dart';
import 'company.dart';
import 'wbobject.dart';

class Products extends WBCollection<Product> {
  Products._() {
    collectionName = "products";
    ref = fireInst.collection(collectionName!).withConverter<Product>(
        fromFirestore: (snap, _) => Product.fromJson(snap.data()!),
        toFirestore: (product, _) => product.toJson());
  }

  static Products instance = Products._();

  factory Products() {
    if (instance.collectionName == '') {
      instance = Products._();
    }
    return instance;
  }
}

class Product extends WBObject {
  String? id, name, companyID, prefix, hsn, poNum, poDate;
  bool? gst;
  double? price;

  int? invoicesCount = 0, dcsCount = 0;
  Company? company;

  Product({
    @required this.id,
    @required this.name,
    @required this.companyID,
    @required this.prefix,
    @required this.hsn,
    @required this.gst,
    @required this.price,
    @required this.poNum,
    @required this.poDate,
  });

  factory Product.fromJson(Map<dynamic, dynamic> i) {
    Product o = Product(
      id: i["id"] ?? Utils.generateId("product_"),
      name: i["name"] ?? "",
      companyID: i["company"] ?? "",
      prefix: i["prefix"] ?? "",
      hsn: i["hsn"] ?? "",
      poNum: i["poNum"] ?? "",
      poDate: i["poDate"] ?? "",
      gst: i["gst"] ?? false,
      price: (i["price"] ?? 0).toDouble(),
    );
    o.company = Companies.instance.map[o.companyID];
    return o;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "company": companyID,
      "prefix": prefix,
      "hsn": hsn,
      "gst": gst,
      "price": price,
      "poNum": poNum,
      "poDate": poDate,
    };
  }
}
