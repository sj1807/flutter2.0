import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
import './detailedwo.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Viewwo extends StatelessWidget{
 final String loca;
 Viewwo(this.loca);
 

  String removezero(String a){
    var temp = int.parse(a);
    //  print("$temp convertedd value");
    return temp.toString();
  }


  Future<List<WorkOrder>> httpcall() async {

    print('$loca, selected location');
    var tempo;
    switch(loca){
      case "General Electric M1 Plant":{tempo="GEM1";}break;
      case "General Electric C1 Plant":{tempo="GEC1";}break;
      
      default:{tempo="GEC1";}
    }
    print("$tempo converted to ");
    var uri =  Uri.parse("$baseUrl/pm/wolist");
    try{
      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'loc' : '$tempo'
          }),
      );
      //print(response.body);
      final resp = json.decode(response.body);
      final temp = resp["status"]["RESULTS"]["item"];
      print(temp);
      List<WorkOrder> workorders = [];
      //print(resp["status"]["NOTIFICATIONS"]["item"] );
      if(resp["status"]["RESULTS"]["item"]!=null){
        print("ok user");
        for(var items in temp ){
        //print(items);
        var a="0";var b="NA";var c="NA"; var d="NA"; var e="NA";
        if(items["ORDERID"]["_text"]!=null){a=items["ORDERID"]["_text"] ;}
        if(items["CONTROL_KEY"]["_text"]!=null){b=items["CONTROL_KEY"]["_text"] ;}
        if(items["EARL_SCHED_START_DATE"]["_text"]!=null){c=items["EARL_SCHED_START_DATE"]["_text"] ;}
        if(items["S_STATUS"]["_text"]!=null){d=items["S_STATUS"]["_text"] ;}
        if(items["DESCRIPTION"]["_text"]!=null){e=items["DESCRIPTION"]["_text"] ;}


        
        WorkOrder data = WorkOrder(a,b,c,d,e);
        workorders.add(data);
      }
      print(workorders.length);
      return workorders;
      }
      else{
      //  _showtoast(context, "Incorrect UserId / Password");
        var a="0";var b="NA";var c="NA"; var d="Not Created"; var e="No notifications available";
        WorkOrder data = WorkOrder(a,b, c,d,e);
        workorders.add(data);
        return workorders;
      }

    }

    catch(error){
      print(error);
      var a="0";var b="NA";var c="NA"; var d="Error"; var e="Server error";
        WorkOrder data = WorkOrder(a,b, c,d,e);
        List<WorkOrder> workorders = [];
        workorders.add(data);
        return workorders;

    }
  }


  @override

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: Text('View WorkOrders',
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
            child: Text("Workorders operations for $loca are displayed below",
              textAlign: TextAlign.center,)
            ),
          Container(
            child:FutureBuilder(
              future: httpcall(),
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
                        leading: Text("Type\n"+snapshot.data[index].type,style: TextStyle(color:Colors.red[400]),),
                        trailing: Icon(Icons.arrow_forward_ios),
                        subtitle: Text("  Date:"+snapshot.data[index].date+"\n  Description:"+snapshot.data[index].description,style: TextStyle(color:Colors.blue),),
                        title: Text("Order No.: "+removezero(snapshot.data[index].number)+"\nStatus: "+snapshot.data[index].status),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>(Detailedwo(snapshot.data[index].number)),
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
            icon: Icon(Icons.home,color: Color.fromRGBO(220, 5, 5, 100),),
            title: new Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: new Text("view notifications")
          )
        ],
        onTap: (index){
          print("$index this is tapped index");
          if(index == 0){
            Navigator.pushReplacementNamed(context, '/home');
          }
          if(index == 1){
            Navigator.pushReplacementNamed(context, '/vbnote');
          }
        },
      ),
    );
  }
}

class WorkOrder{
  final String number;
  final String  type;
  final String date;
  final String status;
  final String description;

  WorkOrder( this.number, this.type, this.date, this.status, this.description);
}
