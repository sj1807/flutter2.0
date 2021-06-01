import 'package:flutter/material.dart';

class Cselection extends StatefulWidget{
  @override
  State<Cselection> createState() => new _State();
}

class _State extends State<Cselection>{

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the desired operation ',
            style: TextStyle(
                fontSize: 15
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child:ListView(
            //scrollDirection: Axis.horizontal,\
            children: <Widget>[
              Container(
                height: 250,
                width:150,
              //  alignment: Alignment.topCenter,
                padding: EdgeInsets.all(10),
                child:GestureDetector(
                  onTap:()async{
                    Navigator.pushNamed(context, '/bnote');
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
                        Image.asset('assets/breaknoti.jpg'),
                        Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("Create Breakdown\n   Notification",
                            style:TextStyle(
                                color: Colors.white
                            )),)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 250,
                width:150,
                //alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child:GestureDetector(
                  onTap:()async{
                    Navigator.pushNamed(context, '/maint');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue,
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //width:15
                      children: [
                        Image.asset('assets/maintnotif.png'),
                        Container(padding: const EdgeInsets.all(8),alignment:Alignment.center,child: Text("Create Preventive\n   Notificaitons",
                            style:TextStyle(
                                color: Colors.white
                            )),)
                      ],
                    ),
                  ),
                ),
              ),
            ]
        )
      ),
    );
  }
}