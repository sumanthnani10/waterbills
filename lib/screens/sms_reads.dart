import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils.dart';

class SMSReader extends StatefulWidget {
  const SMSReader({Key? key}) : super(key: key);

  @override
  State<SMSReader> createState() => _SMSReaderState();
}

class _SMSReaderState extends State<SMSReader> {
  List smss = [];
  Set froms = {};
  String filterPerson = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadSMSs();
    });
  }

  Future<void> loadSMSs() async {
    Utils.showLoadingDialog(context, "Getting");
    smss = [];
    await FirebaseFirestore.instance
        .collection("sotps")
        .orderBy("at", descending: true)
        .get()
        .then((value) {
      smss = value.docs;
      smss.forEach((e) {
        froms.add(e["to"]);
      });
    });
    FirebaseApp otherFirebase = Firebase.app('netadmin');

    FirebaseFirestore firestore = await FirebaseFirestore.instanceFor(app: otherFirebase);

    await firestore
        .collection("sotps")
        .orderBy("at", descending: true)
        .get()
        .then((value) {
      smss.addAll(value.docs);
      smss.forEach((e) {
        froms.add(e["to"]);
      });
    });

    smss.sort((a, b) => b["at"].toString().compareTo(a["at"].toString()),);

    setState(() {
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SMS"),
          centerTitle: false,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  loadSMSs();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: const Text(
                  "Reload",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.green))),
              child: Wrap(
                runSpacing: 8,
                children: [
                      const Text("From: "),
                      const SizedBox(
                        width: 8,
                      )
                    ] +
                    List.generate(
                        froms.length,
                        (index) => InkWell(
                              onTap: () {
                                if (filterPerson == froms.elementAt(index)) {
                                  filterPerson = "";
                                } else {
                                  filterPerson = froms.elementAt(index);
                                }
                                setState(() {

                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                    color:
                                        froms.elementAt(index) == filterPerson
                                            ? Colors.blueAccent
                                            : Colors.lightBlueAccent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4000))),
                                child: Text("${froms.elementAt(index)}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ),
                            )),
              ),
            ),
            Flexible(
              child: ListView.builder(
                key: Key(Utils.generateId("key")!),
                itemCount: smss.length,
                itemBuilder: (context, i) => filterPerson == "" || smss[i]['to']==filterPerson?SMSCard(key: Key(smss[i]["at"].toString()), smss[i], onDelete: () async {
                Utils.showLoadingDialog(context, "Deleting");
                await FirebaseFirestore.instance
                    .collection("sotps")
                    .doc(smss[i].id)
                    .delete();
                Navigator.pop(context);
                loadSMSs();
              },):Container(),),
            ),
          ],
        ));
  }
}

class SMSCard extends StatefulWidget {
  final QueryDocumentSnapshot sms;
  final VoidCallback onDelete;

  SMSCard(this.sms, {Key? key, required this.onDelete}) : super(key: key);

  @override
  State<SMSCard> createState() => _SMSCardState(sms, onDelete);
}

class _SMSCardState extends State<SMSCard> {
  QueryDocumentSnapshot sms;
  VoidCallback onDelete;

  _SMSCardState(this.sms, this.onDelete);

  List<String> otps = [];
  DateTime at = DateTime(2022);

  @override
  void initState() {
    super.initState();
    otps = sms["msg"]
        .replaceAll(RegExp(r'\D'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .split(" ");
    otps.removeWhere((element) => ![4,5,6,8,10].contains(element.length));
    at = sms['at'].toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
              onPressed: (context) async {
                onDelete();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: "Delete"),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${sms["from"]}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  Utils.formatDate(at, true)!,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text("${sms["msg"]}"),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 4,
              children: List.generate(
                  otps.length,
                      (index) => InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: otps[index]))
                          .then((value) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Copied.'),
                          duration: Duration(milliseconds: 300),
                        ));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius:
                          BorderRadius.all(Radius.circular(4000))),
                      child: Text(otps[index],
                          style: const TextStyle(fontSize: 14, color: Colors.blue)),
                    ),
                  )),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "${sms["to"]}",
                  style: const TextStyle(fontSize: 10, color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
