// @dart=2.9
import 'package:flutter/material.dart';
import './Login.dart';
import './sessionlog.dart';
import './Dashboard.dart';
import './Createselection.dart';
import './breakdown.dart';
import './viewbreakdown.dart';
import './selectfunctional.dart';
import './maintenancecreate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var baseUrl = "https://d9382bf8c914.ngrok.io";
int logg=1;
var sessionuser="";
String bdate = '2008-01-01';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message:$message ");
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
      var session =  prefs.getString("user");
      print('$session from sharedprinting prevoius token');
       if(session==''||session==null){
        logg=0;
      }else{logg=1;sessionuser=session;}

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {print(logg);
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.blue,highlightColor: Colors.blueGrey), home: logg==1? Dashboard() : LoginPage(),
    routes:{
      '/login': (context) => LoginPage(),
      '/home': (context) =>Dashboard(),
      '/inter': (context) => Cselection(),
      '/bnote':(context) => Breakdown(),
      '/vbnote': (context) =>VBreakdown(),
      '/maint':(context)=>MBreakdown(),
      '/wolist': (context) =>Selectfun(),
      //'/wosele' : (context)=>
      //'/wolist': (context) =>Sessionlog()
    }
    );
  }//build widget

}//