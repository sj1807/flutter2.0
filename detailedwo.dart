
import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
//import './viewbreakdown.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './changewo.dart';

class Detailedwo extends StatefulWidget{
  final String wonum;
  Detailedwo(this.wonum);
  
  @override
  State<Detailedwo> createState() => new _State();
}

class _State extends State<Detailedwo>{

   bool expanded = false;
   bool mexpanded = false;
   bool aexpanded = false;

    @override

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: Text('Detailed Workorder - '+ removezero(widget.wonum),
            style: TextStyle(
                fontSize: 15
            )
          ),
      ),
      body: Scrollbar(
        child: Container(
          child: FutureBuilder(
            future: httpcall(widget.wonum),
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
                    Container(
                      height: 100,
                      color: Colors.blue,
                      child:Center(
                        child: Text(snapshot.data[0].type,
                          style: TextStyle(
                            color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: RichText(
                          text:TextSpan(
                          children : <TextSpan>[
                            TextSpan(text : 'WorkOrder Number : ',style : TextStyle(color: Colors.black)),
                            TextSpan(text : removezero(widget.wonum), style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        )
                       // Text('Notification Number : '+removezero(notinum))
                      ),
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Order Header :',
                        style: TextStyle(
                          fontSize:18,fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children:<TextSpan>[
                            TextSpan(text:'Equipment No. : ' ,style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].equipment, style:TextStyle(color:Colors.black,fontWeight : FontWeight.bold)),
                          ],
                        ),
                      ),
                      //Text('Equipment No./Name : ' +removezero(snapshot.data[0].equipment) 
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:'Priority : ',style: TextStyle(color:Colors.black) ),
                            TextSpan(text:snapshot.data[0].priority,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold )),
                            TextSpan(text:'\n\nDescription : ',style: TextStyle(color:Colors.black) ),
                            TextSpan(text:snapshot.data[0].shorttxt,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ) ),
                            TextSpan(text:'\n\nOrder Status : ',style: TextStyle(color:Colors.black ) ),
                            TextSpan(text:snapshot.data[0].status,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ) ),
                            TextSpan(text:'\n\nOrder date : ',style: TextStyle(color:Colors.black ) ),
                            TextSpan(text:snapshot.data[0].orderdate,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ) ),
                            TextSpan(text:'\n\nChange date : ',style: TextStyle(color:Colors.black) ),
                            TextSpan(text:snapshot.data[0].changedate,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold )),
                            TextSpan(text:'\n\nCorresponding Notification No : ',style: TextStyle(color:Colors.black) ),
                            TextSpan(text:snapshot.data[0].number,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold )),
                            
                          ],
                        ),
                      )
                     // Text('Priority : '+ + '\n\nDescription : '+  + '\n\nNotification Status : '+),
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),
                /*    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Order Operation Details :',
                        style: TextStyle(
                          fontSize:18,fontWeight: FontWeight.bold
                        ),
                      ),
                    ), */
                    
                 /*   Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('Material Requirement Details :',
                        style: TextStyle(
                          fontSize:18,fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  */  
                    
                    
                    Container(
                      child: ExpansionPanelList(
  animationDuration: Duration(milliseconds:1000),
  dividerColor:Colors.red,
  elevation:1,
  children: [
    ExpansionPanel(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text:TextSpan(
                          children:<TextSpan>[
                            TextSpan(text: '\u{25AA}Operation :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].operation,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Status  :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].opstatus ,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Location / Workcenter  :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].workcenter+' / '+snapshot.data[0].functional ,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Person responsible :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].personresp,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Cost :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].cost +' '+snapshot.data[0].currency,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Operation duration :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].operationduration +' Hr',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Work duration :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].workduration +' Hr',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Work start \nDate/time:  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].earlystartdate +'/'+snapshot.data[0].earlystarttime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\n\u{25AA}Work finish \nDate/time :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].earlyenddate+'/'+snapshot.data[0].earlyendtime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            
                          ]
                        )
                      )
                      //Text('The notification is created from the company'+snapshot.data[0].company+' in the plant ' ),
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),

            SizedBox(height:30,),


           

          ],
        ),
      ),
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Operation Details",
            style: TextStyle(            
              fontSize:18,fontWeight: FontWeight.bold
            ),
          ),
        );
      },
      isExpanded: expanded,
    )
  ],
  expansionCallback: (int item, bool status) {
    setState(() {
      expanded =
      !expanded;
    });
  },
),
                    ),
                    Container(
                      child: ExpansionPanelList(
  animationDuration: Duration(milliseconds:1000),
  dividerColor:Colors.red,
  elevation:1,
  children: [
    ExpansionPanel(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
  
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children:<TextSpan>[
                            TextSpan(text:'\u{25AA}Material No. : ' ,style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].material, style:TextStyle(color:Colors.black,fontWeight : FontWeight.bold)),
                            TextSpan(text:'\n\n\u{25AA}Material : ' ,style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].mattext, style:TextStyle(color:Colors.black,fontWeight : FontWeight.bold)),
                            TextSpan(text:'\n\n\u{25AA}Quantity : ' ,style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].quantity, style:TextStyle(color:Colors.black,fontWeight : FontWeight.bold)),
                          ],
                        ),
                      ),
                      //Text('Equipment No./Name : ' +removezero(snapshot.data[0].equipment) 
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),


            SizedBox(height:30,),


           

          ],
        ),
      ),
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Material Requirement Details",
            style: TextStyle(
              fontSize:18,fontWeight: FontWeight.bold
            ),
          ),
        );
      },
      isExpanded: mexpanded,
    )
  ],
  expansionCallback: (int item, bool status) {
    setState(() {
      mexpanded =
      !mexpanded;
    });
  },
),
                    ),
                    Container(
                      child: ExpansionPanelList(
  animationDuration: Duration(milliseconds:1000),
  dividerColor:Colors.red,
  elevation:1,
  children: [
    ExpansionPanel(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:CrossAxisAlignment.start,
          children: <Widget>[
           Container(
                      child: operation.length ==0 ? 
                      Text('           No additional activities'):
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15),
                        physics: ClampingScrollPhysics(),
                        itemCount: operation.length,
                        itemBuilder: (BuildContext ctxt, int index){
                          return new Text('\n\u{25AA}Operation: '+operation[index].odes+
                          '\n     Workcenter: '+operation[index].owork+
                          '\n     Duration: '+ operation[index].duration+
                          '\n     Person : ' + operation[index].person+
                          '\n     Status : '+operation[index].status+
                          '\n     Start date : '+operation[index].startdate);
                        })
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),


            SizedBox(height:30,),


           

          ],
        ),
      ),
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Additional Operation ,if any",
            style: TextStyle(
              fontSize:18,fontWeight: FontWeight.bold
            ),
          ),
        );
      },
      isExpanded: aexpanded,
    )
  ],
  expansionCallback: (int item, bool status) {
    setState(() {
      aexpanded =
      !aexpanded;
    });
  },
),
                    )

                  ]
                );
              }
            }

          ),
        ),
      ),
      
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("View workorder")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit,color: Color.fromRGBO(5, 5, 220, 100),),
            title: new Text("Change workorder")
          )
        ],
        onTap: (index){
          print('pushed index is $index'+sender[0].status);
            if(index==0){
              Navigator.pushReplacementNamed(context, '/wolist');
            }
            if(index==1){
              if(sender[0].status.contains('Created')||sender[0].status.contains('CRTD')){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Changewo(widget.wonum,sender)
              ),);
              }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cannot change closed or confirmed order')));
}
              //Navigator.pushReplacementNamed(context, '/vbnote');
            }
        }
      )
    );

  }
}
   List<Notificationdetailswo> sender = [];
class Operations{
  final String odes;
  final String owork;
  final String status;
  final String duration;
  final String startdate;
  final String person;
  Operations(this.odes,this.owork,this.status,this.duration,this.startdate,this.person);
}
List<Operations> operation = [];

class Notificationdetailswo{
  final String number; //a
  final String type; //b
  final String status; //c
  final String priority; //d
  final String shorttxt; //e
  final String equipment; //f
  final String functional; //g
  final String orderdate;//h
  final String changedate;//i
  final String operation;//j
  final String workcenter;//k
  final String opstatus;//l
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
  final String operationduration;
  final String currency;//w

  Notificationdetailswo(this.number,this.type,this.status,this.priority,this.shorttxt,this.equipment,this.functional,this.orderdate,
  this.changedate,this.operation,this.workcenter,this.opstatus,this.workduration,this.personresp,this.cost,this.earlystartdate,this.earlystarttime,
  this.earlyenddate,this.earlyendtime,this.material,this.mattext,this.quantity,this.operationduration,this.currency);

}

 Future<List<Notificationdetailswo>> httpcall(String number) async {
   sender.clear();
   operation.clear();
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
      List<Notificationdetailswo> details = [];
      //print(resp["status"]["NOTIFICATIONS"]["item"] );
      if(temp!=null){
        print("ok user");

        var a="Not created";var b="NA";var c="NA"; var d="NA"; var e="NA";var f="0";var g="NA";
        var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "no";var t = "na";var u = "na";
        var v = "na";var w ="na";var x="na";

        if(temp["HEADER"]["ORDER_TYPE"]["_text"]!=null){
          switch(temp["HEADER"]["ORDER_TYPE"]["_text"]){
            case 'PM01':{b="Plant Maintenance Order";}break;
            case 'PM02':{b="Breakdown Maintenance Order";}break;
            case 'PM03':{b="Maintenance Order/Notification";}break;
            default:{ b=temp["HEADER"]["ORDER_TYPE"]["_text"];}break;
          }
          
          ;}//1ordertype
        if(temp["HEADER"]["SYS_STATUS"]["_text"]!=null){
          if(temp["HEADER"]["SYS_STATUS"]["_text"].contains('CRTD')){
            c='Created';
          }
          if(temp["HEADER"]["SYS_STATUS"]["_text"].contains('CLSD')){
            c='Closed';
          }//2status
          }else{c=temp["HEADER"]["SYS_STATUS"]["_text"] ;}
        if(temp["HEADER"]["PRIORITY"]["_text"]!=null){
          //print('prito'+temp["HEADER"]["PRIORITY"]["_text"]);
          switch(temp["HEADER"]["PRIORITY"]["_text"]){
            case '1' :{d="Very High";}break;
            case '2' :{d="High";}break;
            case '3' :{d="Medium";}break;
            case '4' :{d="Low";}break;
            default:{d=temp["HEADER"]["PRIORITY"]["_text"];}break;

          };
        }
          
          //d=temp["HEADER"]["PRIORITY"]["_text"] ;}//3priority
        if(temp["HEADER"]["SHORT_TEXT"]["_text"]!=null){e=temp["HEADER"]["SHORT_TEXT"]["_text"] ;}//4shorttext
        if(temp["HEADER"]["EQUIPMENT"]["_text"]!=null){f=removezero(temp["HEADER"]["EQUIPMENT"]["_text"] );}//5equipment
        if(temp["HEADER"]["FUNCT_LOC"]["_text"]!=null){g=temp["HEADER"]["FUNCT_LOC"]["_text"] ;}//6eqiname
        if(temp["HEADER"]["ENTER_DATE"]["_text"]!=null){h=temp["HEADER"]["ENTER_DATE"]["_text"] ;}//7orderdarte
        if(temp["HEADER"]["CHANGE_DATE"]["_text"]!=null){i=temp["HEADER"]["CHANGE_DATE"]["_text"] ;}//8changedate


      try{
        for (var items in temp["OPERATIONS"]["item"]){
          if(items["DESCRIPTION"]["_text"]!=null){j=items["DESCRIPTION"]["_text"] ;}//9 operation
          if(items["WORK_CNTR"]["_text"]!=null){k=items["WORK_CNTR"]["_text"] ;}//10 workcenter
          if(items["SYSTEM_STATUS_TEXT"]["_text"]!=null){
            print(items["SYSTEM_STATUS_TEXT"]["_text"]);
            if(items["SYSTEM_STATUS_TEXT"]["_text"].contains('CRTD')){
              l="Created";
            }
            else if(items["SYSTEM_STATUS_TEXT"]["_text"].contains('CNF')){
              l="Confirmed";
            }
            else if(items["SYSTEM_STATUS_TEXT"]["_text"].contains('TECO')){
              l="Technically Completed";
            }else{
            l=items["SYSTEM_STATUS_TEXT"]["_text"] ;
            }//12 opstatus
          }//12 opstatus
          if(items["DURATION_NORMAL"]["_text"]!=null){m=items["DURATION_NORMAL"]["_text"] ;}//13 workduration
          if(items["PERS_NO"]["_text"]!=null){n=removezero(items["PERS_NO"]["_text"]) ;}//14 person
          if(items["PRICE"]["_text"]!=null){o=items["PRICE"]["_text"];}//+' '+temp["OPERATIONS"]["item"]["CURRENCY"]["_text"];}//15 cost
          if(items["CURRENCY"]["_text"]!=null){x=items["CURRENCY"]["_text"];}//+' '+temp["OPERATIONS"]["item"]["CURRENCY"]["_text"];}//15 cost
          if(items["EARL_SCHED_START_DATE"]["_text"]!=null){p=items["EARL_SCHED_START_DATE"]["_text"] ;}//16 startdate
          if(items["EARL_SCHED_START_TIME"]["_text"]!=null){q=items["EARL_SCHED_START_TIME"]["_text"] ;}//17 start time
          if(items["EARL_SCHED_FIN_DATE"]["_text"]!=null){r=items["EARL_SCHED_FIN_DATE"]["_text"] ;}//18 end date
          if(items["EARL_SCHED_FIN_TIME"]["_text"]!=null){s=items["EARL_SCHED_FIN_TIME"]["_text"] ;}//19 end time
          if(items["WORK_ACTIVITY"]["_text"]!=null){w=items["WORK_ACTIVITY"]["_text"] ;}//23 operation duration

          Operations odata =  Operations(j,k,l,m,p,n);
          operation.add(odata);
          print('no.of operations:${operation.length}');

        }
      }catch(error){
        if(temp["OPERATIONS"]["item"]["DESCRIPTION"]["_text"]!=null){j=temp["OPERATIONS"]["item"]["DESCRIPTION"]["_text"] ;}//9 operation
        if(temp["OPERATIONS"]["item"]["WORK_CNTR"]["_text"]!=null){k=temp["OPERATIONS"]["item"]["WORK_CNTR"]["_text"] ;}//10 workcenter
        if(temp["OPERATIONS"]["item"]["SYSTEM_STATUS_TEXT"]["_text"]!=null){
            //print(items["SYSTEM_STATUS_TEXT"]["_text"]);
            if(temp["OPERATIONS"]["item"]["SYSTEM_STATUS_TEXT"]["_text"].contains('CRTD')){
              l="Created";
            }
            else if(temp["OPERATIONS"]["item"]["SYSTEM_STATUS_TEXT"]["_text"].contains('CNF')){
              l="Confirmed";
            }
            else if(temp["OPERATIONS"]["item"]["SYSTEM_STATUS_TEXT"]["_text"].contains('TECO')){
              l="Technically Completed";
            }else{
            l=temp["OPERATIONS"]["item"]["SYSTEM_STATUS_TEXT"]["_text"];
            }//12 opstatus
          }//12 opstatus
        if(temp["OPERATIONS"]["item"]["DURATION_NORMAL"]["_text"]!=null){m=temp["OPERATIONS"]["item"]["DURATION_NORMAL"]["_text"] ;}//13 workduration
        if(temp["OPERATIONS"]["item"]["PERS_NO"]["_text"]!=null){n=removezero(temp["OPERATIONS"]["item"]["PERS_NO"]["_text"]) ;}//14 person
        if(temp["OPERATIONS"]["item"]["PRICE"]["_text"]!=null){o=temp["OPERATIONS"]["item"]["PRICE"]["_text"];}//+' '+temp["OPERATIONS"]["item"]["CURRENCY"]["_text"];}//15 cost
        if(temp["OPERATIONS"]["item"]["CURRENCY"]["_text"]!=null){x=temp["OPERATIONS"]["item"]["CURRENCY"]["_text"];}//+' '+temp["OPERATIONS"]["item"]["CURRENCY"]["_text"];}//15 cost
        if(temp["OPERATIONS"]["item"]["EARL_SCHED_START_DATE"]["_text"]!=null){p=temp["OPERATIONS"]["item"]["EARL_SCHED_START_DATE"]["_text"] ;}//16 startdate
        if(temp["OPERATIONS"]["item"]["EARL_SCHED_START_TIME"]["_text"]!=null){q=temp["OPERATIONS"]["item"]["EARL_SCHED_START_TIME"]["_text"] ;}//17 start time
        if(temp["OPERATIONS"]["item"]["EARL_SCHED_FIN_DATE"]["_text"]!=null){r=temp["OPERATIONS"]["item"]["EARL_SCHED_FIN_DATE"]["_text"] ;}//18 end date
        if(temp["OPERATIONS"]["item"]["EARL_SCHED_FIN_TIME"]["_text"]!=null){s=temp["OPERATIONS"]["item"]["EARL_SCHED_FIN_TIME"]["_text"] ;}//19 end time
        if(temp["OPERATIONS"]["item"]["WORK_ACTIVITY"]["_text"]!=null){w=temp["OPERATIONS"]["item"]["WORK_ACTIVITY"]["_text"] ;}//23 operation duration
        
      }





        if(temp["MATERIAL"]["_text"]!=null){t=removezero(temp["MATERIAL"]["_text"]) ;}//20 material
        if(temp["MATTEXT"]["_text"]!=null){u=temp["MATTEXT"]["_text"] ;}//21 mattext
        if(temp["QUANTITY"]["_text"]!=null){v=temp["QUANTITY"]["_text"] ;}//22 quantity
        if(temp["HEADER"]["NOTIF_NO"]["_text"]!=null){a=removezero(temp["HEADER"]["NOTIF_NO"]["_text"]) ;}//24 notifno








        


        
        Notificationdetailswo data = Notificationdetailswo(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x);
        details.add(data);
        sender.add(data);
      print(details.length);
      return details;
      }
      else{
      //  _showtoast(context, "Incorrect UserId / Password");
        var a="0";var b="NA";var c="NA"; var d="Not Created"; var e="No notifications available";var f="0";var g="NA";
        var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "na";var t = "na";var u = "na";
        var v = "na";var w ="na";var x ="na";
        Notificationdetailswo data = Notificationdetailswo(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x);
        details.add(data);
        return details;
      }

    }

    catch(error,stacktrace){
      print('error is  $error\m ${stacktrace.toString()}');
      var a="0";var b="NA";var c="NA"; var d="Error"; var e="Server error";
      var f="NA";var g="NA";
      var h="NA";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="NA";
      var o = "na";var p = "na";var q = "na";var r = "na";var s = "na";var t = "na";var u = "na";
        var v = "na";var w ="na";
        Notificationdetailswo data = Notificationdetailswo(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,w);
        List<Notificationdetailswo> details = [];
        details.add(data);
        return details;

    }
  }
String removezero(String a){
  try{
  var temp = int.parse(a);
  //  print("$temp convertedd value");
  return temp.toString();
  }catch(error){
      return (a);
  }
}