import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './main.dart';
import './sessionlog.dart';
import './wofromnotification.dart';

import 'package:intl/intl.dart';


class Breakdown extends StatefulWidget{
  @override
  State<Breakdown> createState() => new _State();
}

class _State extends State<Breakdown>{

var notifno;
  Future<void> sendnoti(String temps)async{
    var uri =  Uri.parse("$baseUrl/sendnoti");
    try{
      final response = await http.post(uri,
        headers: <String,String>{
         'Content-Type':'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String>{
          "fcmtoken":'$fcm',
          "title" : "Created Breakdown Notification",
           "message":"Created by:$sessionuser - $temps"

          }),
      );
    }catch(error){print(error);}

  }

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
      var lv_task = '';var lv_cause = '';
      if(task.text!=''||task.text!=null || task.text != 'undefined'){
        lv_task = task.text;
      }
      if(cause.text!=''||cause.text!=null || cause.text != 'undefined'){
        lv_cause = cause.text;
      }


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
            'mstime' : '',
            'cause' : lv_cause,
            'task' : lv_task,//starttime.text, 
            'type': 'B2'//16

          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]["LV_NOTIFICATION"]["_text"]!=null){
        print("ok user");
        var temps = resp["status"]["LV_NOTIFICATION"]["_text"];
        print(temps);
        var temp = int.parse(temps);
        Logs ldata = Logs('Created a Breakdown Notification Number is : $temp');
        sessionlog.add(ldata);
        sendnoti('Created Notification Number is : $temp');
        this.notifno = temp;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created Notification Number is : $temp')));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Creation error verify your datas')));

      }
       
  }
   catch(error,stacktrace){
      print(error);
      print(stacktrace);
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
  TextEditingController cause = TextEditingController();
  TextEditingController task = TextEditingController();
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async{
                    DateTime? date;
                    date =  await showDatePicker(
                      context : context,
                      firstDate : DateTime(DateTime.now().year-10),
                      lastDate : DateTime(DateTime.now().year+1),
                      initialDate: DateTime.now(),
                    );
                    if(date != null ){
                      var lvdate = DateFormat("yyyy-MM-dd").format(date);
                  //    print (lvdate);
                      setState((){
                         
                          startdate.text = lvdate;

                      });
                    }
                  } ,
                    ),
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.watch_later_rounded),
                      onPressed: () async{
                    TimeOfDay? time;
                    time =  await showTimePicker(
                      context : context,
                      initialTime: TimeOfDay.now(),
                    );
                    if(time != null ){
                      final now = new DateTime.now();
                      final dt = DateTime(now.year,now.month,now.day,time.hour,time.minute);
                      final format = DateFormat("HH:mm:ss").format(dt);
                     print (time);
                      setState((){
                          starttime.text = format;
                      });
                    }
                  } ),
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async{
                    DateTime? date;
                    date =  await showDatePicker(
                      context : context,
                      firstDate : DateTime(DateTime.now().year-10),
                      lastDate : DateTime(DateTime.now().year+1),
                      initialDate: DateTime.now(),
                    );
                    if(date != null ){
                      var lvdate = DateFormat("yyyy-MM-dd").format(date);
                  //    print (lvdate);
                      setState((){
                         
                          enddate.text = lvdate;

                      });
                    }
                  } ,
                    ),
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: endtime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Breakdown End time",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.watch_later_rounded),
                      onPressed: () async{
                    TimeOfDay? time;
                    time =  await showTimePicker(
                      context : context,
                      initialTime: TimeOfDay.now(),
                    );
                    if(time != null ){
                      final now = new DateTime.now();
                      final dt = DateTime(now.year,now.month,now.day,time.hour,time.minute);
                      final format = DateFormat("HH:mm:ss").format(dt);
                     print (time);
                      setState((){
                          endtime.text = format;
                      });
                    }
                  } ),
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
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: cause,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Cause",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                )
              ), Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: task,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Task",
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    print("notif valur ${this.notifno}");
                    if (notifno == null || notifno == 'undefined') {

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Create a notification first')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Redirecting Data')));
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Cnworkorder(notifno),
                      ),);
                      
                    }

                  },
                  child: Text('Create Corresponding Workorder'),
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