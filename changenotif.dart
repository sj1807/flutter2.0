
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './main.dart';
import './detailednotification.dart';
import './sessionlog.dart';



class Changenotif extends StatefulWidget{
  final List<Notificationdetails> details;
  final String notinum;
  Changenotif ( this.details, this.notinum);
  @override
  State<Changenotif> createState() => new _State();
}

class _State extends State<Changenotif>{
  

  Future<void> sendnoti(String temps)async{
    var uri =  Uri.parse("$baseUrl/sendnoti");
    try{
      final response = await http.post(uri,
        headers: <String,String>{
         'Content-Type':'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,String>{
          "fcmtoken":'$fcm',
          "title" : "Notification Changed ",
           "message":"Changed by:$sessionuser - $temps"

          }),
      );
    }catch(error){print(error);}

  }
httpcall() async {
   // print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/pm/notichange");
    try{
      var lv_priority; var lv_isbreak;
      if(dropdownValue=='Yes'){lv_isbreak="X";}
      if(dropdownValue=='No'){lv_isbreak='';}
      if(priority=='VeryHigh'){lv_priority="1";}
      if(priority=='High'){lv_priority="2";}
      if(priority=='Medium'){lv_priority="3";}
      if(priority=='Low'){lv_priority="4";}
      var lv_bedate='';var lv_betime='';var lv_bsdate='';var lv_bstime='';var des='';
      var lv_medate=''; var lv_metime='';var lv_msdate='';var lv_time='';var lv_partner='';
      var lv_reporter='';
      if(benddate.text!='undefined'){lv_bedate=benddate.text;}
      if(bendtime.text!='undefined'){lv_betime=bendtime.text;}
      if(bstartdate.text!='undefined'){lv_bsdate=bstartdate.text;}
      if(bstarttime.text!='undefined'){lv_bstime=bstarttime.text;}
      if(desc.text!='undefined'){des=desc.text;}
      if(menddate.text!='undefined'){lv_medate=menddate.text;}
      if(mendtime.text!='undefined'){lv_metime=mendtime.text;}
      if(mstartdate.text!='undefined'){lv_msdate=mstartdate.text;}
      if(mstarttime.text!='undefined'){lv_time=mstarttime.text;}
      if(partner.text!='undefined'){lv_partner=partner.text;}
      if(reporter.text!='undefined'){lv_reporter=reporter.text;}


      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'benddate' : lv_bedate,//1
            'bendtime' : lv_betime,//2
            'bstartdate' : lv_bsdate, //3
            'bstarttime' : lv_bstime, //4 
            'desc' : des, //5
            'isbreak' : lv_isbreak, //6
            'menddate' : lv_medate, //7
            'mendtime' : lv_metime, //8
            'mstartdate' : lv_msdate, //9 
            'mstarttime' : lv_time, //10
            'partner' : lv_partner, //11
            'priority' : lv_priority, //12
            'reporter' :lv_reporter,//enddate.text, //13
            'notifno' : widget.notinum,//endtime.text, //14

          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]!=null){
        print("ok user");
        try{
        var temps = resp["status"]["NOTIFHEADER_EXPORT"]["NOTIF_NO"]["_text"];
        print(temps);
        var temp = int.parse(temps);
        Logs ldata = Logs('Changed notification details of : $temp');
        sessionlog.add(ldata);
        sendnoti('Changed Notification Number is : $temp');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Changed Notification Number is : $temp')));
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
  TextEditingController benddate = TextEditingController();
  TextEditingController bendtime = TextEditingController();
  TextEditingController bstartdate = TextEditingController();
  TextEditingController bstarttime = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController menddate = TextEditingController();
  TextEditingController mendtime = TextEditingController();
  TextEditingController mstartdate = TextEditingController();
  TextEditingController mstarttime = TextEditingController();
  TextEditingController partner = TextEditingController();
  TextEditingController reporter = TextEditingController();
  TextEditingController notifno = TextEditingController();

  String dropdownValue = 'No';
  String priority = 'Low';
  //String location = 'GEC Mechanical Works';

  @override


  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Changing Notification - ${widget.notinum}',
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
                child: Text("Select Priority: Current value - ${widget.details[0].priority}"),
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
                child: Text("Heading : Current value- ${widget.details[0].shorttxt}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: desc,
                  decoration: new InputDecoration(
                    labelText: "Heading:",
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
                child: Text("Requesting Start date: Current value- ${widget.details[0].mstart}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: mstartdate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Start Date :",
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
                child: Text("Start time: Current value - ${widget.details[0].mstarttime}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: mstarttime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Start Time",
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
                child: Text("End date: Current value - ${widget.details[0].mend}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: menddate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "End Date",
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
                child: Text("End time: Current value - ${widget.details[0].mendtime}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: mendtime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "End time",
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
                child: Text("Person Responsible: Current value -  ${widget.details[0].partner}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: partner,
                  // The validator receives the text that the user has entered.
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    labelText: "Person Responsible",
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
                child: Text("Reported by: Current value- ${widget.details[0].reportedby}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: reporter,
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
                )
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: Text("Select If Breakdown : current type: ${widget.details[0].type}"),
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
                      'Yes',
                      'No'
                      
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
                child: Text("Malfunction start date: Current value- ${widget.details[0].bstart}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: bstartdate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Malfunction Start date",
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
                child: Text("Start time: Current value- ${widget.details[0].bstarttime}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: bstarttime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Malfunction start time",
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
                child: Text("End date: Current value- ${widget.details[0].bend}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: benddate,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Malfunction end date",
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
                child: Text("End time: Current value- ${widget.details[0].bendtime}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: bendtime,
                  // The validator receives the text that the user has entered.
                  decoration: new InputDecoration(
                    labelText: "Malfunction end time",
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
            icon: Icon(Icons.edit,color: Color.fromRGBO(220, 5, 5, 100),),
            title: new Text("Change  Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("View Notifications")
          )
        ],
        onTap: (index){
            if(index==1){
              Navigator.pushReplacementNamed(context, '/vbnote');
            }
          print("$index this is tapped index");
        },
      ),
    );
  }
}