import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './main.dart';


class Cworkorder extends StatefulWidget{
  @override
  State<Cworkorder> createState() => new _State();
}

class _State extends State<Cworkorder>{


httpcall() async {
   // print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/pm/wocreate");
    try{
      var lv_priority; var lv_machine; var lv_ordertype;
      if(equipment=='CNC Machine'){lv_machine="10000159";}
      if(equipment=='Grinding Machine'){lv_machine="10000030";}
      if(equipment=='UT Compressor'){lv_machine="10000003";}
      if(equipment=='Screw Guage'){lv_machine="10000025";}
      if(priority=='VeryHigh'){lv_priority="1";}
      if(priority=='High'){lv_priority="2";}
      if(priority=='Medium'){lv_priority="3";}
      if(priority=='Low'){lv_priority="4";}
      if(ordertype=='Plant Maintenance Order'){lv_ordertype="PM01";}
      if(ordertype=='Breakdown Maintenance Order'){lv_ordertype="PM02";}


      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'deatileddes' : deatileddes.text,//enddate.text,//1
            'workhr' : workhr.text,//endtime.text,//2
            'equipment' : lv_machine,//startdate.text, //3
            'material' : material.text,//starttime.text, //4 
            'notifno' : notifno.text, //5
            'notiftype' : lv_priority, //6
            'ordertype' : lv_ordertype , //7
            'persno' : persno.text, //8
            'reqquantity' : reqquantity.text , //9 
            'shortext' : shortext.text, //10
            'activitydur' : activitydur.text , //11

          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]!=null){
        print("ok user");
        var temps = resp["status"]["MESSAGE"]["_text"];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$temps')));
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
  TextEditingController deatileddes = TextEditingController();//1
  TextEditingController workhr = TextEditingController();//2
  TextEditingController material = TextEditingController();//3
  TextEditingController notifno = TextEditingController();//4
  TextEditingController notiftype = TextEditingController();//5
  TextEditingController persno = TextEditingController();//6
  TextEditingController reqquantity = TextEditingController();//7
  TextEditingController shortext = TextEditingController();//8
  TextEditingController activitydur = TextEditingController();//9
  String equipment = 'Grinding Machine';//10
  String priority = 'High';//11
  String ordertype = 'Plant Maintenance Order';

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workorder',
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
                    value: equipment,
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
                        equipment = newValue.toString();
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
                child: Text("Select Order type:"),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    value: ordertype,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      //width: 100,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: ( newValue) {
                      setState(() {
                        ordertype = newValue.toString();
                      });
                    },
                    items: <String>[
                      'Plant Maintenance Order',
                      'Breakdown Maintenance Order',
                      
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
                  controller: shortext,
                  decoration: new InputDecoration(
                    labelText: "Order heading",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter order heading';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: notifno,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Notification number",
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
                  controller: deatileddes,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Activity Description",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the activity';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: workhr,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Activity Duration",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter duration';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: persno,
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
                  controller: activitydur,
                  // The validator receives the text that the user has entered.
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    labelText: "Work Duration",
                    contentPadding: EdgeInsets.all(20.0),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Work Duration';
                    }
                    return null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: material,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Required Material",
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
                  controller: reqquantity,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Required Quantity",
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
            icon: Icon(Icons.home,color: Color.fromRGBO(220, 5, 5, 100),),
            title: new Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("View Workorders")
          )
        ],
        onTap: (index){
            if(index==0){
              Navigator.pushReplacementNamed(context, '/home');
            }
            if(index==1){
              Navigator.pushReplacementNamed(context, '/wolist');
            }
          print("$index this is tapped index");
        },
      ),
    );
  }
}