/*import 'dart:convert';

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:tutorial/restAPICalls.dart';



class Sessionlog extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  String messageTitle = "Empty";
  String messageText = "Empty";
  String notificationAlert = "alert";

  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*_firebaseMessaging.configure(
      onMessage: (message) async{
        print(message["notification"]["title"]);
        print(message["notification"]["body"]);

        setState(() {
          messageTitle = message["notification"]["title"];
          messageText = message["notification"]["body"];
          notificationAlert = "New Notification Alert";
        });
      },
      onResume: (message) async{
        setState(() {
          messageTitle = message["data"]["title"];
          messageText = message["data"]["body"];
          notificationAlert = "Application opened from Notification";
        });

      },
    );
  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("widget.title"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              notificationAlert,
              style: Theme.of(context).textTheme.headline4,
            ),

            SizedBox(
              height: 50,
            ),

            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
                messageText,
              style: Theme.of(context).textTheme.bodyText1,

            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(
           // context,
            //MaterialPageRoute(
             // builder: (context) => RestAPICalls(),
            //),
          //);
        },
        tooltip: '',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // postRequrest({String job_cat_id}) async {
  //   // var url = Uri.https('education4u.in', '/api/v1/GetMBASubCategories',{'subcat_id':'${widget.cat_id}'});
  //   var url = Uri.https('reqres.in', '/api/users/GetMBASubCategories',{'name':'morpheus','job':'leader'});
  //
  //   var response = await http.post(url);
  //   if (response.statusCode == 201) {
  //     var responseData = jsonDecode(response.body);
  //     responseData["result"].forEach((element) {
  //
  //     });
  //     setState(() {
  //       // _isLoading = false;
  //     });
  //   }
  // }
  //
  // getRequest() async {
  //   var url = Uri.https('reqres.in', '/api/users/page=2');
  //   var response = await http.get(url);
  //   print(url);
  //   if (response.statusCode == 200) {
  //     var responseData = jsonDecode(response.body);
  //     responseData["result"].forEach((element) {
  //       // if (element["liveimg_path"] == null) {
  //
  //       // }
  //     });
  //   }
  //
  //   setState(() {
  //     // _isLoading = false;
  //   });*/
   }


}
*/