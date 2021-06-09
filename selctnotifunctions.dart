import 'package:flutter/material.dart';
import './functionalnotification.dart';


class Selectfunnoti extends StatefulWidget{
    @override
  State<Selectfunnoti> createState() => new _State();
}

class _State extends State<Selectfunnoti> {

  String location = 'General Electric M1 Plant';
  @override

  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title:Text ('Notification selection ',
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
              child: Text("         Select Plant to view notification"),
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
                  'General Electric M1 Plant',
                  'General Electric C1 Plant',
                      
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>(Vfunnoti(location)),
                      ));
                  },
                  child: Text('Goto notification'),
                ),
            ),
          ]
        ),
      ),
    );
  }

}