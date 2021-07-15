import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
import './detailedwo.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Viewwo extends StatefulWidget{
  final String loca;
 Viewwo(this.loca);

  
  @override
  State<Viewwo> createState() => new _State();
}

class _State extends State<Viewwo>{
 
 
TextEditingController searcher = TextEditingController();
  String removezero(String a){
    var temp = int.parse(a);
    //  print("$temp convertedd value");
    return temp.toString();
  }


  Future<List<WorkOrder>> httpcall() async {

    print('${widget.loca}, selected location');
    var tempo;
    switch(widget.loca){
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


  List<WorkOrder> workorderscontrol = [];
  List<WorkOrder> copydata = [];

void initState(){
  super.initState();
  searcher.text="0";
  
}

onItemChanged(String value){
 List<WorkOrder> results = [];
  if(value.isEmpty){
setState(() {
        workorderscontrol = copydata;
});
       return;
  }else{
      workorderscontrol.forEach((number) { 
        if(number.number.contains(value)){
          results.add(number);
          print(number.number);
        }
    });
    setState(() {
          workorderscontrol = results;
        });
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
            child: Text("Workorders operations for ${widget.loca} are displayed below",
              textAlign: TextAlign.center,)
            ),
            Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searcher,
              decoration: InputDecoration(
                hintText:"Search Notifications by number",
                icon: Icon(Icons.search)
              ),
              onChanged: onItemChanged,
            )
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
                  copydata = snapshot.data;
                  
                  return ListView.builder(
                    //scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: workorderscontrol.length,
                    itemBuilder: (BuildContext context , int index){
                      return Card(
                        color: Colors.grey[100],
                        child:ListTile(
                        leading: Text("Type\n"+workorderscontrol[index].type,style: TextStyle(color:Colors.red[400]),),
                        trailing: Icon(Icons.arrow_forward_ios),
                        subtitle: Text("  Date:"+workorderscontrol[index].date+"\n  Description:"+workorderscontrol[index].description,style: TextStyle(color:Colors.blue),),
                        title: Text("Order No.: "+removezero(workorderscontrol[index].number)+"\nStatus: "+workorderscontrol[index].status),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>(Detailedwo(workorderscontrol[index].number)),
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
