
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Logout extends StatefulWidget{
  @override
  State<Logout> createState() => new _State();
}
class _State extends State<Logout>{

  @override
    Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout Confirmation'),
      ),
      body: Center(
      child:Container(
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
                          Navigator.pushReplacementNamed(context,'/home')
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
                          Icon(Icons.home,color: Colors.white,size:50.0),
                       //   Image.asset('assets/home.png'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("Go home",
                              style:TextStyle(
                                  color: Colors.black
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
                      onTap: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("user", '');
                        print('logout!! cleared previous token');
                        //await LocalStorage('localstorage_app').setItem('user', '');
                          Navigator.pushReplacementNamed(context,'/login');
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
                          Icon(Icons.logout,color: Colors.white,size:50.0),
                          //Image.asset('assets/logout.png'),
                          Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text(" Yes Logout",
                              style:TextStyle(
                                  color: Colors.black
                              )),)
                        ],
                      ),
                    ),
                    ),
                  ),
                  
                ])
                )
                )
                );


    }
}