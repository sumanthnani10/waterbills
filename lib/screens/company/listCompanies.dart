import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterbills/objects/company.dart';
import 'package:waterbills/screens/company/aEVCompany.dart';
import 'package:waterbills/screens/listLayout.dart';
import 'package:waterbills/screens/products/listProducts.dart';

import '../../utils.dart';
import '../sms_reads.dart';

class ListCompanyScreen extends StatefulWidget {
  const ListCompanyScreen({Key? key}) : super(key: key);

  @override
  _ListCompanyScreenState createState() => _ListCompanyScreenState();
}

class _ListCompanyScreenState extends State<ListCompanyScreen> {
  List companies = [];
  int restrCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadList();
    });
  }

  Future<bool> checkPermissions() async {
    if(kIsWeb) return true;
    return (await Permission.sms.request().isGranted);
  }

  loadList([reload = false]) async {
    Utils.showLoadingDialog(context, "Loading...");
    if (reload) {
      await Companies.instance.getCollection();
      Utils.updateObjects();
    }
    companies = Companies.instance.list;
    Navigator.pop(context);
    setState(() {});
    checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return ListScreenLayout(
      title: "Companies",
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () async {
                var r = await _showPasswordDialog("Enter Password", "") ??
                    [false];
                if(r[0]) {
                  if(r[1] == "seeotps") {
                    Navigator.push(context, Utils.createRoute(SMSReader(), Utils.DTU));
                  } else {
                    Utils.showErrorDialog(context, "Wrong Password", "Enter correct password.");
                  }
                }
              },
              child: Container(
                height: 10,
                color: Colors.white,
              ),
            )
          ]+List<Widget>.generate(companies.length, (i) {
            Company? company = companies[i];
            return InkWell(
                onTap: () async {
                  await Navigator.push(
                      context,
                      Utils.createRoute(
                          ListProductScreen(company!.id), Utils.DTU));
                  loadList();
                },
                child: CompanyCard(
                  company,
                  goToView: () async {
                    await Navigator.push(
                        context,
                        Utils.createRoute(
                            AVECompanyScreen(
                              company: company,
                              view: true,
                            ),
                            Utils.DTU));
                    loadList();
                  },
                ));
          }),
        ),
      ),
      addScreen: AVECompanyScreen(company: Company.fromJson({}), add: true),
      actions: [
        TextButton.icon(
            onPressed: () async {
              if (restrCount < 10) {
                restrCount++;
                return;
              }
              restrCount = 0;
              ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                content: Text("${Utils.restricted! ? "Un" : ""}Locked"),
              )));
              var prefs = await SharedPreferences.getInstance();
              Utils.restricted = !Utils.restricted!;
              prefs.setBool("restricted", Utils.restricted!);
              setState(() {});
            },
            icon: Icon(
              Icons.lock_open,
              color: Colors.purple,
              size: 10,
            ),
            label: Text(
              "Restriction",
              style: const TextStyle(color: Colors.purple, fontSize: 10),
            )),
        TextButton.icon(
            onPressed: () => loadList(true),
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: Text(
              "Reload",
              style: const TextStyle(color: Colors.white),
            ))
      ],
      onReload: () => loadList(true),
    );
  }

  Future _showPasswordDialog(String title, String password) {
    GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var passwordC = TextEditingController(text: password);
        return AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey2,
            child: TextFormField(
              controller: passwordC,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Please enter password';
                } else if (v.isEmpty) {
                  return 'Please enter password with 8 chars';
                } else {
                  return null;
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop([false, ""]);
              },
            ),
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                if (formKey2.currentState!.validate()) {
                  Navigator.of(context)
                      .pop([true, passwordC.text]);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Company? company;
  final VoidCallback? goToView;

  CompanyCard(this.company, {@required this.goToView, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.cyan),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.factory_rounded, color: Colors.white),
          SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "${company!.name}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Flexible(
                child: Text(
                  "${company!.productsCount} Products | ${company!.invoicesCount} Invoices | ${company!.dcsCount} DCs",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
                onTap: goToView,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                  child: Icon(Icons.remove_red_eye, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
