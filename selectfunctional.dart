import './workorderview.dart';
import './main.dart';
import 'package:flutter/material.dart';

class Selectfun extends StatefulWidget{
    @override
  State<Selectfun> createState() => new _State();
}

class _State extends State<Selectfun> {

  String location = 'GEC Mechanical Works';
  @override

  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title:Text ('Work order selection ',
            style: TextStyle(
                fontSize: 15
            )
          )
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
            //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(1),
              child: Text("         Select Functional Location to view workorders"),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DropdownButton<String>(
                value: location,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  //width: 100,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  setState(() {
                    location = newValue.toString();
                    });
                    print(location);
                },
                items: <String>[
                  'GEC Mechanical Works',
                  'Production Block1',
                  'Steel Melt Shop',
                  'Instrument Maintenance'    
                ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Redirection for $location Data')));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>(Viewwo(location)),
                      ));
                  },
                  child: Text('Get WorkOrders'),
                ),
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Text("          Or to create work order click the below button"),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Redirection for $location Data')));
                     Navigator.pushNamed(context, '/cwo');
                      //)
                      //);
                  },
                  child: Text('Create WorkOrders'),
                ),
            ),


          ]
        ),
      ),
    );
  }

}