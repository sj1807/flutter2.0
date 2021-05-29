import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './main.dart';


class Breakdown extends StatefulWidget{
  @override
  State<Breakdown> createState() => new _State();
}

class _State extends State<Breakdown>{


httpcall() async {
   // print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/pm/noticreate");
    try{
      var lv_priority; var lv_machine; var lv_location;
      if(dropdownValue=='CNC Machine'){lv_machine="10000159";}
      if(dropdownValue=='Grinding Machine'){lv_machine="10000030";}
      if(dropdownValue=='UT Compressor'){lv_machine="10000003";}
      if(dropdownValue=='Screw Guage'){lv_machine="10000025";}
      if(priority=='VeryHigh'){lv_priority="1";}
      if(priority=='High'){lv_priority="2";}
      if(priority=='Medium'){lv_priority="3";}
      if(priority=='Low'){lv_priority="4";}
      if(location=='GEC Mechanical Works'){lv_location="GEC-MECH";}
      if(location=='Production Block1'){lv_location="4000-300";}
      if(location=='Steel Melt Shop'){lv_location="CNS1-PL2-SM";}
      if(location=='Instrument Maintenance'){lv_location="SCREW_GUAGE";}


      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'bdownedate' : enddate.text,//1
            'bdownetime' : endtime.text,//2
            'bdownsdate' : startdate.text, //3
            'bdownstime' : starttime.text, //4 
            'shorttext' : shortnote.text, //5
            'machine' : lv_machine, //6
            'location' : lv_location, //7
            'isbreak' : 'X', //8
            'description' : details.text, //9 
            'partner' : person.text, //10
            'priority' : lv_priority, //11
            'reporter' : reportedby.text, //12
            'medate' : '',//enddate.text, //13
            'metime' : '',//endtime.text, //14
            'msdate' : '',//startdate.text, //15
            'mstime' : '',//starttime.text, 
            'type': 'B1'//16

          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]!=null){
        print("ok user");
        var temps = resp["status"]["LV_NOTIFICATION"]["_text"];
        var temp = int.parse(temps);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created Notification Number is : $temp')));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Creation error verify your datas')));

      }
       
  }
   catch(error){
      print(error);
    }
  }


  final _formKey = GlobalKey<FormState>();
  //TextEditingController functional = TextEditingController();
  TextEditingController shortnote = TextEditingController();
  TextEditingController startdate = TextEditingController();
  TextEditingController enddate = TextEditingController();
  TextEditingController starttime = TextEditingController();
  TextEditingController endtime = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController reportedby = TextEditingController();
  TextEditingController person = TextEditingController();
  String dropdownValue = 'Grinding Machine';
  String priority = 'High';
  String location = 'GEC Mechanical Works';

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Breakdown Notification',
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
                padding: EdgeInsets.all(1),
                child: Text("Select Equipment:"),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: dropdownValue,
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
                        dropdownValue = newValue.toString();
                      });
                    },
                    items: <String>[
                      'Grinding Machine',
                      'CNC Machine',
                      'UT Compressor',
                      'Screw Guage'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                  ),
              Padding(
                padding: EdgeInsets.all(1),
                child: Text("Select Priority:"),
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
                padding: EdgeInsets.all(1),
                child: Text("Select fuctional location:"),
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: shortnote,
                  decoration: new InputDecoration(
                    labelText: "Notification heading",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter notification heading';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: startdate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Breakdown Start Date",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter breakdown starting date';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: starttime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Breakdown Start Time",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter starting time';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: enddate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Breakdown End Date",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter breakdown ending date';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: endtime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Breakdown End time",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter breakdown end time';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: details,
                  // The validator receives the text that the user has entered.
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    labelText: "Detailed Breakdown Description",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Detailed description';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: reportedby,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Reporting person",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: person,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Person Responsible",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter person responsible';
                    }
                    return null;
                  },
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
                      print(shortnote.text);
                      print(startdate.text);
                      print(enddate.text);
                      print(starttime.text);
                      print(endtime.text);
                      print(details.text);
                      print(reportedby.text);
                      print(person.text);
                      print(priority);
                      if(priority=="Medium"){
                        print(1);
                      }
                      print(dropdownValue);
                      httpcall();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'),
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
            icon: Icon(Icons.warning,color: Color.fromRGBO(220, 5, 5, 100),),
            title: new Text("Breakdown Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("Maintenance Notifications")
          )
        ],
        onTap: (index){
            if(index==1){
              Navigator.pushReplacementNamed(context, '/maint');
            }
          print("$index this is tapped index");
        },
      ),
    );
  }
}