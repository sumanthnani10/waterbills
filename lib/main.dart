import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterbills/firebase_options.dart';
import 'package:waterbills/firebase_options_netadmin.dart';
import 'package:waterbills/screens/company/listCompanies.dart';
import 'package:waterbills/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(
    name: 'netadmin',
    options: NetadminFirebaseOptions.options,
  );
  if (kIsWeb)
    runApp(Center(
        child: ClipRect(
            child: SizedBox(
                width: 420,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      fontFamily: 'Poppins',
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.75)),
                        floatingLabelStyle:
                            TextStyle(color: Colors.black.withOpacity(0.75)),
                      )),
                  home: SplashScreen(),
                )))));
  else
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black.withOpacity(0.75)),
            floatingLabelStyle:
                TextStyle(color: Colors.black.withOpacity(0.75)),
          )),
      home: SplashScreen(),
    ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loaded = false;
  Color color = Colors.cyan;
  List<Color> colors = [Colors.lightBlue, Colors.indigo, Colors.purple];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animate();
      loadCollections();
    });
  }

  loadCollections() async {
    await Utils.loadAll();
    loaded = true;
    proceed();
  }

  animate() async {
    if (colors.isEmpty) {
      proceed();
      return;
    }
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      color = colors.first;
      colors.removeAt(0);
    });
    animate();
  }

  proceed() async {
    var prefs = await SharedPreferences.getInstance();
    if (kIsWeb) {
      Utils.restricted = false;
    } else {
      Utils.restricted = prefs.getBool("restricted");
      if (Utils.restricted == null) {
        Utils.restricted = true;
        prefs.setBool("restricted", true);
      }
    }

    if (loaded && colors.isEmpty) {
      Navigator.pushReplacement(
          context, Utils.createRoute(ListCompanyScreen(), Utils.UTD));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: AnimatedContainer(
          padding: const EdgeInsets.all(16),
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Water Bills",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              )),
            ],
          )),
    );
  }
}
