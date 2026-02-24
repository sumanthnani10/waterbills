import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waterbills/utils.dart';

class WBCollection<T> {
  String? collectionName;
  List<T> list = [];
  Map<String, T> map = {};
  CollectionReference? ref;
  FirebaseFirestore fireInst = FirebaseFirestore.instance;

  getCollection() async {
    list = [];
    map.clear();
    await ref!.get().then((value) {
      value.docs.forEach((element) {
        list.add(element.data() as T);
        map[element.id] = list.last!;
      });
    });
  }

  upsert(data, [edit = false, matchValue, matchKey = "name"]) async {
    var l;
    if (matchKey == "name") {
      matchValue = data.name;
      l = await ref!.where("$matchKey", isEqualTo: "${data.name}").get();
    } else {
      l = await ref!.where("$matchKey", isEqualTo: "${matchValue ?? "~"}").get();
    }
    if (edit || l.docs.length == 0) {
      if (l.docs.length > 0 && l.docs.first.id != data.id) {
        print("Edit Error: ID Mismatch");
        return "Edit Error: ID Mismatch";
      }
      await ref!.doc(data.id).set(data);
      await getCollection();
      Utils.updateObjects();
      return null;
    } else {
      print("${collectionName!.toUpperCase()} Already Exists with $matchValue.");
      return "${collectionName!.toUpperCase()} Already Exists with $matchValue.";
    }
  }

  delete(data) async {
    await ref!.doc(data.id).delete();
    await getCollection();
    Utils.updateObjects();
    return null;
  }
}

class WBObject {
  WBObject();

  WBObject.fromJson(Map<dynamic, dynamic> i) : this();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }
}
