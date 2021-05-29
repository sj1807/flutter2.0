
import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
//import './viewbreakdown.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Detailedwo extends StatelessWidget{
  final String wonum;
  Detailedwo(this.wonum);
    @override

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: Text('Detailed Workorder - '+ removezero(wonum),
            style: TextStyle(
                fontSize: 15
            )
          ),
      ),
      body: Scrollbar(
        child: Container(
          child: FutureBuilder(
            future: httpcall(wonum),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else{
                return ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[

                  ]
                );
              }
            }

          ),
        ),
      ),
    );



  }
}

class Notificationdetails{
  final String number; //a
  final String type; //b
  final String status; //c
  final String priority; //d
  final String shorttxt; //e
  final String equipment; //f
  final String equipmentname; //g
  final String orderdate;//h
  final String changedate;//i
  final String operation;//j
  final String plant;//k
  final String workcenter;//l
  final String workduration;//m
  final String personresp;//n
  final String cost;//o
  final String earlystartdate;//p
  final String earlystarttime;//q
  final String earlyenddate;//r
  final String earlyendtime;//s
  final String material;//t
  final String mattext;//u
  final String quantity;//v
  final String operationduration;//w

  Notificationdetails(this.number,this.type,this.status,this.priority,this.shorttxt,this.equipment,this.equipmentname,this.orderdate,
  this.changedate,this.operation,this.plant,this.workcenter,this.workduration,this.personresp,this.cost,this.earlystartdate,this.earlystarttime,
  this.earlyenddate,this.earlyendtime,this.material,this.mattext,this.quantity,this.operationduration);

}

 Future<List<Notificationdetails>> httpcall(String number) async {

    print('$number is selected');
    var uri =  Uri.parse("$baseUrl/pm/wodetails");
    try{
      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'woid' : '$number'
          }),
      );
      //print(response.body);
      final resp = json.decode(response.body);
      final temp = resp["status"];
      print(temp);
      List<Notificationdetails> details = [];
      //print(resp["status"]["NOTIFICATIONS"]["item"] );
      if(temp!=null){
        print("ok user");

        var a="Not created";var b="NA";var c="NA"; var d="NA"; var e="NA";var f="0";var g="NA";
        var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "no";var t = "breakdown";var u = "no";
        var v = "breakdown";var w ="na";
        


        
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w);
        details.add(data);
      print(details.length);
      return details;
      }
      else{
      //  _showtoast(context, "Incorrect UserId / Password");
        var a="0";var b="NA";var c="NA"; var d="Not Created"; var e="No notifications available";var f="0";var g="NA";
        var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "na";var t = "na";var u = "na";
        var v = "na";var w ="na";
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w);
        details.add(data);
        return details;
      }

    }

    catch(error){
      print(error);
      var a="0";var b="NA";var c="NA"; var d="Error"; var e="Server error";
      var f="NA";var g="NA";
      var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
      var o = "na";var p = "na";var q = "na";var r = "na";var s = "na";var t = "na";var u = "na";
        var v = "na";var w ="na";
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w);
        List<Notificationdetails> details = [];
        details.add(data);
        return details;

    }
  }
String removezero(String a){
  var temp = int.parse(a);
  //  print("$temp convertedd value");
  return temp.toString();
}