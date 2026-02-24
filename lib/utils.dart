import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waterbills/objects/vehicle.dart';

import 'objects/company.dart';
import 'objects/dc.dart';
import 'objects/invoice.dart';
import 'objects/product.dart';

class Utils {
  static bool? restricted = true;

  static loadAll() async {
    await Companies.instance.getCollection();
    await Products.instance.getCollection();
    await Invoices.instance.getCollection();
    await DCs.instance.getCollection();
    await Vehicles.instance.getCollection();
    updateObjects();
  }

  static updateObjects() async {
    for (Company obj in Companies.instance.list) {
      obj.productsCount = 0;
      obj.invoicesCount = 0;
      obj.dcsCount = 0;
    }

    for (Product obj in Products.instance.list) {
      obj.invoicesCount = 0;
      obj.dcsCount = 0;

      obj.company = Companies.instance.map[obj.companyID];
      obj.company!.productsCount += 1;
    }

    for (Invoice obj in Invoices.instance.list) {
      obj.dcsCount = 0;

      obj.product = Products.instance.map[obj.productID];
      obj.product!.invoicesCount = obj.product!.invoicesCount! + 1;

      obj.company = Companies.instance.map[obj.product!.companyID];
      obj.companyID = obj.product!.companyID;
      obj.company!.invoicesCount += 1;
    }

    for (DC obj in DCs.instance.list) {
      obj.invoice = Invoices.instance.map[obj.invoiceID];
      obj.invoice!.dcsCount += 1;
      // obj.amount = (obj.quantity * obj.invoice!.price).ceilToDouble();

      obj.product = Products.instance.map[obj.invoice!.productID];
      obj.product!.dcsCount = obj.product!.dcsCount! + 1;

      obj.company = Companies.instance.map[obj.product!.companyID];
      obj.company!.dcsCount = obj.company!.dcsCount + 1;
    }
  }

  static const List<List<String?>> months = [
    ["Month", "Mon"],
    ["January", "Jan"],
    ["February", "Feb"],
    ["March", "Mar"],
    ["April", "Apr"],
    ["May", "May"],
    ["June", "Jun"],
    ["July", "Jul"],
    ["August", "Aug"],
    ["September", "Sep"],
    ["October", "Oct"],
    ["November", "Nov"],
    ["December", "Dec"],
  ];

  static const Offset RTL = Offset(1, 0);
  static const Offset LTR = Offset(-1, 0);
  static const Offset UTD = Offset(0, -1);
  static const Offset DTU = Offset(0, 1);

  static Map<String, dynamic> printSheetHeadings = {
    "Pennar DM": ["PENNAR INDUSTRIES", "DM WATER"],
    "Pennar RO": ["PENNAR INDUSTRIES", "RO WATER"],
    "Veljan DM": ["VELJAN DENSION LTD.", "DM WATER"],
    "Veljan RO": ["VELJAN DENSION LTD.", "RO WATER"],
    "UB": ["UNITED BREWERIES", "RO WATER"],
  };

  static Map<String, dynamic> billTo = {
    "Pennar DM": [
      "Pennar Industries Ltd.",
      "IDA,Isnapur,",
      "Pashamylaram,Medak,502329",
      "GST No. : 36AABCP3074HIZH",
      "DM Water",
      "2201",
      "PDM",
      false
    ],
    "Pennar RO": [
      "Pennar Industries Ltd.",
      "IDA,Isnapur,",
      "Pashamylaram,Medak,502329",
      "GST No. : 36AABCP3074HIZH",
      "RO Water",
      "2201",
      "PRO",
      false
    ],
    "Veljan DM": [
      "Veljan Dension Limited",
      "Plot No. 10A,Phase 1,IDA",
      "Patancheru,Sangareddy,Telangana",
      "GST No. : 36AAACH6114P1ZE",
      "DM Water",
      "996924",
      "VDM",
      true
    ],
    "Veljan RO": [
      "Veljan Dension Limited",
      "Plot No. 10A,Phase 1,IDA",
      "Patancheru,Sangareddy,Telangana",
      "GST No. : 36AAACH6114P1ZE",
      "RO Water",
      "996924",
      "VRO",
      true
    ],
    "UB": [
      "United Breweries King Fisher",
      "Mallepally",
      "Sangareddy,Hyderabad,Telangana",
      "",
      "RO Water",
      "",
      "URO",
      true
    ],
  };

  static String? generateId(String? pref) {
    var chars =
        'zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA9876543210zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA9876543210';
    int charLength = chars.length;
    var t = DateTime.now();
    String? id = pref;
    // id += chars[(t.year / 100).round()];
    id = id! + chars[t.year % charLength];
    id = id + chars[t.month];
    id = id + chars[t.day];
    id = id + chars[t.hour];
    id = id + chars[t.minute];
    id = id + chars[t.second];
    id = id + chars[t.millisecond % charLength];
    id = id + chars[t.microsecond % charLength];
    return id;
  }

  static getPriceInWords(String? price) {
    var l = price!.split(".");
    price = "${l[0]}";
    String? paise = "";
    if (l.length == 2) {
      String? l1 = l[1].split(' ')[0];
      if (l1 != "") {
        if (l1.length > 2) {
          l1 = l1.substring(0, 2);
        }
        if (l1.length == 1) {
          l1 += "0";
        }
        paise = "$l1";
        if (l1 == "00") {
          paise = "";
        }
      }
    }
    var ones = {};
    ones['0'] = '';
    ones['1'] = 'One ';
    ones['2'] = 'Two ';
    ones['3'] = 'Three ';
    ones['4'] = 'Four ';
    ones['5'] = 'Five ';
    ones['6'] = 'Six ';
    ones['7'] = 'Seven ';
    ones['8'] = 'Eight ';
    ones['9'] = 'Nine ';
    var tens = {};
    tens['0'] = '';
    tens['10'] = 'Ten ';
    tens['11'] = 'Eleven ';
    tens['12'] = 'Twelve ';
    tens['13'] = 'Thirteen ';
    tens['14'] = 'Fourteen ';
    tens['15'] = 'Fifteen ';
    tens['16'] = 'Sixteen ';
    tens['17'] = 'Seventeen ';
    tens['18'] = 'Eighteen ';
    tens['19'] = 'Nineteen ';
    tens['2'] = 'Twenty ';
    tens['3'] = 'Thirty ';
    tens['4'] = 'Forty ';
    tens['5'] = 'Fifty ';
    tens['6'] = 'Sixty ';
    tens['7'] = 'Seventy ';
    tens['8'] = 'Eighty ';
    tens['9'] = 'Ninety ';

    String? w = '', rev = price.split('').reversed.join();

    for (int i = 0; i < rev.length; i++) {
      if (i == 0) {
        if (rev.length > 1) {
          if (rev[1] == '1') {
            w = '${tens['${rev[1]}${rev[0]}']}' + w!;
            i += 1;
          } else {
            w = '${ones[rev[i]]}' + w!;
          }
        } else {
          w = '${ones[rev[i]]}' + w!;
        }
      } else if (i == 1) {
        w = '${tens[rev[i]]}' + w!;
      } else if (i == 2) {
        w = '${ones[rev[i]]}${rev[i] != '0' ? 'hundred ' : ''}' + w!;
      } else if (i == 3) {
        if (rev.length > 4) {
          if (rev[4] == '1') {
            w = '${tens['${rev[i + 1]}${rev[i]}']}thousand ' + w!;
            i += 1;
          } else {
            w = '${ones[rev[i]]}${(rev[i] == '0' && rev[i + 1] == '0') ? '' : 'thousand '}' +
                w!;
          }
        } else {
          w = '${ones[rev[i]]}${(rev[i] == '0' && rev[i + 1] == '0') ? '' : 'thousand '}' +
              w!;
        }
      } else if (i == 4) {
        w = '${tens[rev[i]]}' + w!;
      } else if (i == 5) {
        if (rev.length > i + 1) {
          if (rev[i + 1] == '1') {
            w = '${tens['${rev[i + 1]}${rev[i]}']}lakhs ' + w!;
            i += 1;
          } else {
            w = '${ones[rev[i]]}${(rev[i] == '0' && rev[i + 1] == '0') ? '' : rev[i] == '1' ? 'lakh ' : 'lakhs '}' +
                w!;
          }
        } else {
          w = '${ones[rev[i]]}${(rev[i] == '0' && rev[i + 1] == '0') ? '' : rev[i] == '1' ? 'lakh ' : 'lakhs '}' +
              w!;
        }
      } else if (i == 6) {
        w = '${tens[rev[i]]}' + w!;
      } else if (i == 7) {
        if (rev.length > i + 1) {
          if (rev[i + 1] == '1') {
            w = '${tens['${rev[i + 1]}${rev[i]}']}crores ' + w!;
            i += 1;
          } else {
            w = '${ones[rev[i]]}${rev[i] == '1' ? 'crore' : 'crores'} ' + w!;
          }
        } else {
          w = '${ones[rev[i]]}${rev[i] == '1' ? 'crore' : 'crores'} ' + w!;
        }
      } else if (i == 8) {
        w = '${tens[rev[i]]}' + w!;
      } else if (i == 9) {
        w = '${ones[rev[i]]}${rev[i] != '0' ? 'hundred ' : ''}' + w!;
      }
      // print('$i $w');
    }
    w = w! + 'rupees ';

    String? pai = "";

    if (paise.isNotEmpty) {
      rev = paise.split('').reversed.join();

      for (int i = 0; i < rev.length; i++) {
        if (i == 0) {
          if (rev.length > 1) {
            if (rev[1] == '1') {
              pai = '${tens['${rev[1]}${rev[0]}']}' + pai!;
              i += 1;
            } else {
              pai = '${ones[rev[i]]}' + pai!;
            }
          } else {
            pai = '${ones[rev[i]]}' + pai!;
          }
        } else if (i == 1) {
          pai = '${tens[rev[i]]}' + pai!;
        }
      }
      pai = pai! + "paise ";
    }
    w += pai;
    w += "only";
    return w;
  }

  static getPriceWithCommas(String? price) {
    price = "$price${kIsWeb?".00":""}";
    List<String?> l = price.split(".");
    List<String?> digs = l[0]!.split("");
    int len = digs.length;
    price = "";
    for (int i = 1; i <= len; i++) {
      price = "${digs[len - i]}$price";
      if ([3, 5, 7, 9].contains(i) && len - i != 0) {
        price = ",$price";
      }
    }
    return "$price.${l[1]}";
  }

  static String? digitsFormat(int num, [int digits = 2]) {
    String? s = "$num";
    if (s.length < digits) {
      s = List<String?>.generate(digits - s.length, (_) => "0").join("") + s;
    }
    return s;
  }

  static String? formatDate(DateTime dateTime, [bool time = false]) {
    String? s =
        "${digitsFormat(dateTime.day)}/${digitsFormat(dateTime.month)}/${dateTime.year}";
    if (time) {
      s +=
      " ${digitsFormat(dateTime.hour > 12 ? (12 - dateTime.hour) : dateTime.hour)}/${digitsFormat(dateTime.minute)}/${dateTime.second} ${dateTime.hour > 12 ? "PM" : "AM"}";
    }
    return s;
  }

  static DateTime setMonthLastDate(DateTime dateTime) {
    if (dateTime.month == 2) {
      if (dateTime.year % 4 == 0 ||
          (dateTime.year % 400 == 0 && dateTime.year % 100 == 0)) {
        return dateTime.add(Duration(days: 29 - dateTime.day));
      } else {
        return dateTime.add(Duration(days: 28 - dateTime.day));
      }
    } else if ([1, 3, 5, 7, 8, 10, 12].contains(dateTime.month)) {
      return dateTime.add(Duration(days: 31 - dateTime.day));
    } else {
      return dateTime.add(Duration(days: 30 - dateTime.day));
    }
  }

  static Route createRoute(dest, Offset dir) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => dest,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = dir;
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static showLoadingDialog(BuildContext context, String? title) {
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 8,
                  ),
                  Text(title!)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Future showADialog(BuildContext context, String? title, String? message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(message!),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future showConfirmationDialog(BuildContext context, String? title, String? message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(message!),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  static Future showErrorDialog(BuildContext context, String? title, String? message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title!,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(message!),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
