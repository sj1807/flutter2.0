import 'dart:convert';
import './detailednotification.dart';
import 'package:flutter/material.dart';
import './main.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Vfunnoti extends StatefulWidget{
  final String func;
  Vfunnoti(this.func);
  @override
  State<Vfunnoti> createState() => new _State();
}

class _State extends State<Vfunnoti>{
 // String bndate;

    String removezero(String a){
      var temp = int.parse(a);
    //  print("$temp convertedd value");
      return temp.toString();
    }
  TextEditingController dateController = TextEditingController();

  Future<List<Notification>> httpcall(String user, String date) async {
    var tempo;
    switch(widget.func){
      case "General Electric M1 Plant":{tempo="GEM1";}break;
      case "General Electric C1 Plant":{tempo="GEC1";}break;
      default:{tempo="GEC1";}
    }

    print('$user, fselected date $date');
    var uri =  Uri.parse("$baseUrl/pm/notilist");
    try{
      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'location' : '$tempo',

            'date' : '$date',
            'selection' : '2'
          }),
      );
      //print(response.body);
      final resp = json.decode(response.body);
      final temp = resp["status"]["NOTIFICATIONS"]["item"];
      //print(temp);
      List<Notification> notifications = [];
      //print(resp["status"]["NOTIFICATIONS"]["item"] );
      if(resp["status"]["NOTIFICATIONS"]["item"]!=null){
        print("ok user");
        for(var items in temp ){
        //print(items);
        var a="0";var b="NA";var c="NA"; var d="NA"; var e="NA";
        if(items["NOTIFICAT"]["_text"]!=null){a=items["NOTIFICAT"]["_text"] ;}
        if(items["NOTIF_TYPE"]["_text"]!=null){b=items["NOTIF_TYPE"]["_text"] ;}
        if(items["NOTIFDATE"]["_text"]!=null){c=items["NOTIFDATE"]["_text"] ;}
        if(items["S_STATUS"]["_text"]!=null){d=items["S_STATUS"]["_text"] ;}
        if(items["DESCRIPT"]["_text"]!=null){e=items["DESCRIPT"]["_text"] ;}


        
        Notification data = Notification(a,b,c,d,e);
        notifications.add(data);
      }
      print(notifications.length);
      return notifications;
      }
      else{
      //  _showtoast(context, "Incorrect UserId / Password");
        var a="0";var b="NA";var c="NA"; var d="Not Created"; var e="No notifications available";
        Notification data = Notification(a,b, c,d,e);
        notifications.add(data);
        return notifications;
      }

    }

    catch(error){
      print(error);
      var a="0";var b="NA";var c="NA"; var d="Error"; var e="Server error";
        Notification data = Notification(a,b, c,d,e);
        List<Notification> notifications = [];
        notifications.add(data);
        return notifications;

    }
  }


  @override

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: Text('View Location Notification',
            style: TextStyle(
                fontSize: 15
            )),
      ),
      body:Scrollbar(
      child:ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text("Notifications are displayed according to their status",
              textAlign: TextAlign.center,)
            ),
          Container(
            child:FutureBuilder(
              future: httpcall(sessionuser,'2008-01-01'),
              builder: (BuildContext context, AsyncSnapshot snapshot){                      //print(snapshot.data);
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else {
                  return ListView.builder(
                    //scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context , int index){
                      return Card(
                        color: Colors.grey[100],
                        child:ListTile(
                        leading: Text("Type\n"+" "+snapshot.data[index].type,style: TextStyle(color:Colors.red[400]),),
                        trailing: Icon(Icons.arrow_forward_ios),
                        subtitle: Text("  Date:"+snapshot.data[index].date+"\n  Description:"+snapshot.data[index].description,style: TextStyle(color:Colors.blue),),
                        title: Text("Notification No.: "+removezero(snapshot.data[index].number)+"\nStatus: "+snapshot.data[index].status),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Detailednote(snapshot.data[index].number),
                        ),);
                      },
                      )
                      );
                    },
                  );
                }
              }
            )
          )
        ],
      )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on,color: Color.fromRGBO(220, 5, 5, 100),),
            title: new Text("Location notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: new Text("Your Notifications")
          )
        ],
        onTap: (index){
          print("$index this is tapped index");
          if(index == 0){
            //Navigator.pushReplacementNamed(context, '/selntoi');
          }
          if(index == 1){
            Navigator.pushNamed(context, '/vbnote');
          }
        },
      ),
    );
  }
}

class Notification{
  final String number;
  final String  type;
  final String date;
  final String status;
  final String description;

  Notification( this.number, this.type, this.date, this.status, this.description);
}
class Notificationdetails{
  final String number;
  final String type;
  final String status;
  final String priority;
  final String shorttxt;
  final String equipment;
  final String equipmentname;
  final String detailed;
  final String company;
  final String plant;
  final String workcenter;
  final String functional;
  final String reportedby;
  final String partner;
  Notificationdetails(this.number,this.type,this.status,this.priority,this.shorttxt,this.equipment,this.equipmentname,this.detailed,
  this.company,this.partner,this.plant,this.workcenter,this.functional,this.reportedby);

}