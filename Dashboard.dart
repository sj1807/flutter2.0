// @dart=2.9
import 'package:flutter/material.dart';
import './main.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';



class Dashboard extends StatefulWidget{

  
  @override
  State<Dashboard> createState() => new _State();
}//state creation

//dsata declaration area-----------------------
var logger;



class _State extends State<Dashboard>{

@override
  void initState() {
    
    super.initState();

    //print(sessionuser);
    logger=sessionuser;

  }// auto loading

  void _showtoast(BuildContext context) {

    //print(logger);
    final scaffold= ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content:  Text("showing current use ls : $logger "))
    );
  }

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //borderRadius: BorderRadius.all(Radius.circular(8.0)),
            Image.asset('assets/logo.jpg',

                // BorderRadius.circular(50),
                fit: BoxFit.contain,
                height: 32),
            Container(padding: const EdgeInsets.all(8.0), child: Text('Maintenance Portal'))
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child:Scrollbar(
          child:ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text('Welcome to Maintenance Portal',
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue
              ))
            ),
            Container(
              child:GridView.extent(
                shrinkWrap: true,
                primary:false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                maxCrossAxisExtent: 200.0,
                children: <Widget>[
                  Container(
                  //  height: 150,
                  //  width:150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap: ()=>{
                          Navigator.pushNamed(context,'/inter')
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment: Alignment.center,child: Text("    Create\n Notification",
                          style:TextStyle(
                            color: Colors.white
                          )),)
                        ],
                      ),
                    )
                    ),
                  ),
                  Container(
                  //  height: 150,
                  //  width:150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap: ()=>{
                          Navigator.pushNamed(context,'/vbnote')
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("     View\nNotification",
                              style:TextStyle(
                                  color: Colors.white
                              )),)
                        ],
                      ),
                    ),
                    ),
                  ),
                  Container(
                  //  height: 150,
                  //  width:150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap: ()=>{
                          Navigator.pushNamed(context,'/wolist')
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("       View\nWork Orders",
                              style:TextStyle(
                                  color: Colors.white
                              )),)
                        ],
                      ),
                    )
                    ),
                  ),
                  Container(
                    //   height: 150,
                    // width:150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap:()async{
                        print(logger);
                        Navigator.pushNamed(context, '/cwo');
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("    Create\nWork order",
                              style:TextStyle(
                                  color: Colors.white
                              )),)
                        ],
                      ),
                    )
                    ),
                  ),
                  Container(
                 //   height: 150,
                   // width:150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap:()async{
                        print(logger);
                        Navigator.pushNamed(context, '/slog');
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("Session log",
                              style:TextStyle(
                                  color: Colors.white
                              )),)
                        ],
                      ),
                    )
                  ),
                  ),
                  Container(
                    //height: 350,
                    //width:350,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:GestureDetector(
                      onTap:()async{
                        print(logger);
                        //SharedPreferences prefs = await SharedPreferences.getInstance();
                        //prefs.setString("user", '');
                        //print('logout!! cleared previous token');
                        //await LocalStorage('localstorage_app').setItem('user', '');
                        Navigator.pushReplacementNamed(context, '/logout');
                      },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.blue,
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/logo.jpg'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("Logout",
                              style:TextStyle(
                                  color: Colors.white
                              )),)
                        ],
                      ),
                    ),
                    ),
                  ),
                  


                ],
              )
            ),
            //htiles5
            //cheacking
          ],
        ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Text(
            "Current User Id : $logger\nPowered by Firebase. \nCopyright ©2021, All Rights Reserved.",
            textAlign: TextAlign.center,
          ),
          color: Colors.blueAccent
      ),
    );
  }
}

