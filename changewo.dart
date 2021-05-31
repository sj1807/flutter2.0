
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample1/detailedwo.dart';
import 'dart:convert';
import './main.dart';


String removezero(String a){
  try{
  var temp = int.parse(a);
  //  print("$temp convertedd value");
  return temp.toString();
  }catch(error){
      return (a);
  }
}

class Changewo extends StatefulWidget{
   
   final List<Notificationdetailswo> current ;

  final String woid;
  Changewo (this.woid,this.current);
  @override
  State<Changewo> createState() => new _State();
}

class _State extends State<Changewo>{
  
Future<void> sendnoti(String temps)async{
    var uri =  Uri.parse("$baseUrl/sendnoti");
    try{
      final response = await http.post(uri,
        headers: <String,String>{
         'Content-Type':'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String>{
          "fcmtoken":'$fcm',
          "title" : "WorkOrder Changed ",
           "message":"Created by:$sessionuser - $temps"

          }),
      );
    }catch(error){print(error);}

  }

httpcall() async {
   // print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/pm/wochange");
    try{
      var lv_priority;
      if(priority=='VeryHigh'){lv_priority="1";}
      if(priority=='High'){lv_priority="2";}
      if(priority=='Medium'){lv_priority="3";}
      if(priority=='Low'){lv_priority="4";}
      var lv_duration='';var lv_partner='';
      var lv_shorttext='';var lv_des='';
      if(ophr.text!='undefined'){lv_duration=ophr.text;}
      if(persno.text!='undefined'){lv_partner=persno.text;}
      if(shorttext.text!='undefined'){lv_shorttext=shorttext.text;}
      if(opdes.text!='undefined'){lv_des=opdes.text;}

      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'duration' : lv_duration,//1
            'partner' : lv_partner,//2
            'priority' : lv_priority, //3
            'shorttxt' : lv_shorttext, //4 
            'workdes' : lv_des, //5
            'woid' : widget.woid, //6

          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]!=null){
        print("ok user");
        try{
        var temps = resp["status"]["MESSAGE"]["_text"];
        print(temps);
        sendnoti('$temps');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$temps')));
      }catch(error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Change error verify your datas')));

      }
      }
      else{

      }
       
  }
   catch(error,stacktrace){
      print(error);
      print(stacktrace);
    }
  }


  final _formKey = GlobalKey<FormState>();
  //TextEditingController functional = TextEditingController();
  TextEditingController shorttext = TextEditingController();
  TextEditingController persno = TextEditingController();
  TextEditingController opdes = TextEditingController();
  TextEditingController ophr = TextEditingController();


  String dropdownValue = 'No';
  String priority = 'Low';
  //String location = 'GEC Mechanical Works';

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Changing Workorder - ${removezero(widget.woid)}',
        style: TextStyle(
          fontSize: 15
        )),
      ),
      body: Scrollbar(
      child:Padding(
        
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                child:Text("Enter the values you want to change",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              )),
              Container(
                      child: Divider(color: Colors.black,height: 50,),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Select Priority: currentvalue - ${removezero(widget.current[0].priority)}"),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: priority,
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
                        priority = newValue.toString();
                      });
                    },
                    items: <String>[
                      'VeryHigh',
                      'High',
                      'Medium',
                      'Low'
                      
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                  ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Order Heading:current value- ${removezero(widget.current[0].shorttxt)}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: shorttext,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    labelText: "Order Heading:",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Person Responsible : current value- ${removezero(widget.current[0].personresp)}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: persno,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Person Responsible :",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Operation description: current value- ${removezero(widget.current[0].operation)}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: opdes,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Operation description:",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Operation Duration :current value- ${removezero(widget.current[0].operationduration)}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: ophr,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Operation Duration :",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                )
              ),
              

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    final valid = _formKey.currentState!.validate();
                    print(valid);
                    if (valid) {
                    //if (true) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                     // print(functional.text);
                      print("printing in this order");

                      httpcall();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data please wait ...')));
                    }
                  },
                  child: Text('Update'),
                ),
              ),

            ],
          ),
        )
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("View  Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("View Workorders")
          )
        ],
        onTap: (index){
            if(index==1){
              Navigator.pushReplacementNamed(context, '/vbnote');
            }
            if(index==0){
              Navigator.pushReplacementNamed(context, '/wolist');
            }
          print("$index this is tapped index");
        },
      ),
    );
  }
}