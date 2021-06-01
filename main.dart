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
//import './changenotistatus.dart';
import './logout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './createwo.dart';
import './selctnotifunctions.dart';
import './chatscreen.dart';

var baseUrl = "https://96fc6dc97140.ngrok.io";
int logg=1;
var sessionuser="";
var fcm = '';
String bdate = '2008-01-01';

   

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("Handling bgm");
      print('the message is ${message.data}');
    print('the message is ${message.notification}');
  print(message);
  Logs ldata = Logs('Notification Recieved-${message.data["title"]} - ${message.data["body"]}');
  sessionlog.add(ldata);
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging _firebase = FirebaseMessaging.instance;
  String token = await _firebase.getToken();
  fcm = token;
  print(token);


  //const AndroidNotificationChannel

  FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
    print('got a message');
    print('the message is ${message.data}');
    print('the message is ${message.notification}');
      Logs ldata = Logs('Notification Recieved-${message.data["title"]}-${message.data["body"]}');
      sessionlog.add(ldata);
   

    return AlertDialog(
      title: Text("notification recieved"),
    );

  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { 

    print('the message is ${message.data}');
    print('the message is ${message.notification}');
    Logs ldata = Logs('Notification Recieved-${message.data["title"]}-${message.data["body"]}');
    sessionlog.add(ldata);

  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      '/cwo': (context) =>Cworkorder(),
      '/selnoti': (context) => Selectfunnoti(),
      '/logout': (context)=>Logout(),
      '/chatbot': (context)=>ChatScreen(),


      //'/wosele' : (context)=>
      '/slog': (context) =>Sessionlog()
    }
    );
  }//build widget

}//

