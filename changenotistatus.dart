import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './main.dart';
 
class Changenotis extends StatefulWidget{
  
  final String notinum;
  Changenotis ( this.notinum);
  @override
  State<Changenotis> createState() => new _State();
}

class _State extends State<Changenotis>{


 
httpcall() async {
   // print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/pm/notistatus");
    try{
      var lv_selection;
      if(status=='Put-In-Progress'){lv_selection='2';}
      if(status=='Postponed'){lv_selection='1';}
      if(status=='Closed'){lv_selection='3';}


      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'noti' : widget.notinum,//endtime.text, //14
            'selection' : lv_selection

          }),
      );
      final resp = jsonDecode(response.body);
      print (resp);
      String temp = resp["status"]["LV_SYSTEMSTATUS"]["_text"];
      switch(lv_selection){
        case '1':{
          if(temp.contains('NOPO')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification is postponed')));
          }
          if(temp.contains('OSNO')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:Notification is not postponed,Reason:Waiting for approval.')));
          }
          if(temp.contains('NOPR')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cannot postpone notification in progress.')));
          }
        }break;
        case '2':{
          if(temp.contains('NOPR')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification is put in progress')));
          }
          if(temp.contains('OSNO')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:Notification status not changed,try again later.')));
          }
        }break;
        case '3':{
          if(temp.contains('NOCO')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification is Closed')));
          }
          if(temp.contains('OSNO')){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:Notification not closed,try again later.')));
          }
        }break;
      }
      
       
  }
   catch(error,stacktrace){
      print(error);
      print(stacktrace);
    }
  }



  String status = 'Put-In-Progress';

    @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Changing Notification Status',
        style: TextStyle(
          fontSize: 15
        )),
      ),
      body: Scrollbar(
      child:Padding(
        
        padding: EdgeInsets.all(10.0),    
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1),
                child: Text("Select Status:"),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: status,
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
                        status = newValue.toString();
                      });
                    },
                    items: <String>[
                      'Put-In-Progress',
                      'Postponed',
                      'Closed'
                      
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
                    // Validate returns true if the form is valid, or false otherwise.
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data please wait ...')));
                    httpcall();
                  },
                  child: Text('Update'),
                ),
              ),
            ]
          )
      )
      )
    );
  }
}