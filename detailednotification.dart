
import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
//import './viewbreakdown.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class Detailednote extends StatelessWidget{
  final String notinum;
  Detailednote(this.notinum);
    @override

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      appBar: AppBar(
        title: Text('Detailed Notification - '+ removezero(notinum),
            style: TextStyle(
                fontSize: 15
            )
          ),
      ),
      body: Scrollbar(
        child: Container(
          child: FutureBuilder(
            future: httpcall(notinum),
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
                            TextSpan(text : 'Notification Number : ',style : TextStyle(color: Colors.black)),
                            TextSpan(text : removezero(notinum), style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
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
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children:<TextSpan>[
                            TextSpan(text:'Equipment No./Name : ' ,style: TextStyle(color:Colors.black)),
                            TextSpan(text: removezero(snapshot.data[0].equipment) +'/'+snapshot.data[0].equipmentname, style:TextStyle(color:Colors.black,fontWeight : FontWeight.bold)),
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
                            TextSpan(text:'\n\nNotification Status : ',style: TextStyle(color:Colors.black ) ),
                            TextSpan(text:snapshot.data[0].status,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ) ),
                            TextSpan(text:'\n\nNotification date : ',style: TextStyle(color:Colors.black ) ),
                            TextSpan(text:snapshot.data[0].date,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold ) ),
                          ],
                        ),
                      )
                     // Text('Priority : '+ + '\n\nDescription : '+  + '\n\nNotification Status : '+),
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ), 
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('More Details :',
                        style: TextStyle(
                          fontSize:18,fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text:TextSpan(
                          children:<TextSpan>[
                            TextSpan(text: '\u{25AA}Requested Start \n     Date/Time          :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].mstart+' / '+snapshot.data[0].mstarttime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\u{25AA}Requested End \n     Date/Time          :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].mend +' / '+snapshot.data[0].mendtime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                          ]
                        )
                      )
                      //Text('The notification is created from the company'+snapshot.data[0].company+' in the plant ' ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text:TextSpan(
                          children:<TextSpan>[
                            TextSpan(text: '\u{25AA}Breakdown Start \n     Date/Time          :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].bstart+' / '+snapshot.data[0].bstarttime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\n\u{25AA}Breakdown End \n     Date/Time          :  ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].bend +' / '+snapshot.data[0].bendtime,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                          ]
                        )
                      )
                      //Text('The notification is created from the company'+snapshot.data[0].company+' in the plant ' ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(text: TextSpan(
                        children:<TextSpan>[
                          TextSpan(text: '\u{25AA}Detailed Description : ',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                          TextSpan(text: snapshot.data[0].detailed,style: TextStyle(color:Colors.black)),

                        ]
                      ))
                      //Text(+ ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text:TextSpan(
                          children:<TextSpan>[
                            TextSpan(text: '\u{25AA}The notification is created for the company : ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].company,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                            TextSpan(text: ' in the plant ',style: TextStyle(color:Colors.black)),
                            TextSpan(text: snapshot.data[0].plant,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                          ]
                        )
                      )
                      //Text('The notification is created from the company'+snapshot.data[0].company+' in the plant ' ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children:<TextSpan>[
                            TextSpan(text: '\u{25AA}The workcenter and Functional location for this notification is',style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].workcenter +' and '+snapshot.data[0].functional,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),

                          ]
                        ),
                      )//Text('The workcenter and Functional location for this notification is'+ ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:'\u{25AA}This Notification is raised by ',style: TextStyle(color:Colors.black) ),
                            TextSpan(text:snapshot.data[0].reportedby+' and ',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold )),
                            TextSpan(text:'the person responsible is ',style: TextStyle(color:Colors.black)),
                            TextSpan(text:snapshot.data[0].partner,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold )),
                          ]
                        )
                        )
                      //Text('This Notification is raised by '+snapshot.data[0].reportedby++ ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(text: TextSpan(
                        children:<TextSpan>[
                          TextSpan(text: '\u{25AA}Workorder for this notification is ',style: TextStyle(color:Colors.black)),
                          TextSpan(text: snapshot.data[0].number,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),

                        ]
                      ))
                      //Text(+ ),
                    ),
                    Container(
                      child: Divider(color: Colors.black,height: 50,),
                    ),
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
  final String detailed;//h
  final String company;//i
  final String plant;//j
  final String workcenter;//k
  final String functional;//l
  final String reportedby;//m
  final String partner;//n
  final String mstart;//o
  final String mstarttime;//p
  final String mend;//q
  final String mendtime;//r
  final String bstart;//s
  final String bstarttime;//t
  final String bend;//u
  final String bendtime;//v
  final String date;//w
  final String chdate;//x

  Notificationdetails(this.number,this.type,this.status,this.priority,this.shorttxt,this.equipment,this.equipmentname,this.detailed,
  this.company,this.plant,this.workcenter,this.functional,this.reportedby,this.partner,this.mstart,this.mstarttime,
  this.mend,this.mendtime,this.bstart,this.bstarttime,this.bend,this.bendtime,this.date,this.chdate);

}

 Future<List<Notificationdetails>> httpcall(String number) async {

    print('$number is selected');
    var uri =  Uri.parse("$baseUrl/pm/notidetails");
    try{
      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'noti' : '$number'
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
        var h="";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="0";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "no";var t = "breakdown";var u = "no";
        var v = "breakdown";var w ="na";var x="na";
        if(temp["COMPANY"]["_text"]!=null){i=temp["COMPANY"]["_text"] ;}//1
        if(temp["PRIORITY"]["_text"]!=null){d=temp["PRIORITY"]["_text"] ;}//2
        if(temp["PLANT"]["_text"]!=null){j=temp["PLANT"]["_text"] ;}//3
        if(temp["PARTNER"]["_text"]!=null){n=temp["PARTNER"]["_text"] ;}//4
      
        //5
        if(temp["HEADERTEXT"]["EQUIDESCR"]["_text"]!=null){g=temp["HEADERTEXT"]["EQUIDESCR"]["_text"] ;}//6
        if(temp["HEADER"]["EQUIPMENT"]["_text"]!=null){f=temp["HEADER"]["EQUIPMENT"]["_text"] ;}//7
        if(temp["HEADER"]["SHORT_TEXT"]["_text"]!=null){e=temp["HEADER"]["SHORT_TEXT"]["_text"] ;}//8
        if(temp["HEADER"]["SYS_STATUS"]["_text"]!=null){
          switch(temp["HEADER"]["SYS_STATUS"]["_text"]){
            case 'OSNO':{c="Outstanding";}break;
            case 'NOPR':{c="InProgress";}break;
            case 'NOCO':{c="Closed";}break;
            case 'NOPO':{c="Postponed";}break;
            default :{c=temp["HEADER"]["SYS_STATUS"]["_text"];}break;

          }
        }//9
        if(temp["HEADERTEXT"]["WORK_CNTR"]["_text"]!=null){k=temp["HEADERTEXT"]["WORK_CNTR"]["_text"] ;}//10
        if(temp["HEADERTEXT"]["FUNCLDESCR"]["_text"]!=null){l=temp["HEADERTEXT"]["FUNCLDESCR"]["_text"] ;}//11
        if(temp["HEADER"]["REPORTEDBY"]["_text"]!=null){m=temp["HEADER"]["REPORTEDBY"]["_text"] ;}//12
        if(temp["HEADER"]["NOTIF_TYPE"]["_text"]!=null){
          switch(temp["HEADER"]["NOTIF_TYPE"]["_text"]){
            case 'B1':{ b="Preventive Notification";}break;
            case 'B2':{ b="Breakdown Notification";}break;
            case 'M1':{ b="Maintenance Request";}break;
            default:{b=temp["HEADER"]["NOTIF_TYPE"]["_text"];}break;
          }
        }//13
        if(temp["HEADER"]["ORDERID"]["_text"]!=null){a=temp["HEADER"]["ORDERID"]["_text"] ;}//14
        if(temp["HEADER"]["DESSTDATE"]["_text"]!=null){o=temp["HEADER"]["DESSTDATE"]["_text"];}//15
        if(temp["HEADER"]["DESSTTIME"]["_text"]!=null){p=temp["HEADER"]["DESSTTIME"]["_text"];}//16
        if(temp["HEADER"]["DESENDDATE"]["_text"]!=null){q=temp["HEADER"]["DESENDDATE"]["_text"];}//17
        if(temp["HEADER"]["DESENDTM"]["_text"]!=null){r=temp["HEADER"]["DESENDTM"]["_text"];}//18
        //if(temp["HEADER"]["NOTIF_TYPE"]["_text"]=='B2'){
        if(temp["HEADER"]["STRMLFNDATE"]["_text"]!=null){s=temp["HEADER"]["STRMLFNDATE"]["_text"];}//19
        if(temp["HEADER"]["STRMLFNTIME"]["_text"]!=null){t=temp["HEADER"]["STRMLFNTIME"]["_text"];}//20
        if(temp["HEADER"]["ENDMLFNDATE"]["_text"]!=null){u=temp["HEADER"]["ENDMLFNDATE"]["_text"];}//21
        if(temp["HEADER"]["ENDMLFNTIME"]["_text"]!=null){v=temp["HEADER"]["ENDMLFNTIME"]["_text"];}//22

        //}        
        if(temp["HEADER"]["NOTIF_DATE"]["_text"]!=null){w=temp["HEADER"]["NOTIF_DATE"]["_text"];}//22
        if(temp["HEADER"]["CHANGED_ON"]["_text"]!=null){x=temp["HEADER"]["CHANGED_ON"]["_text"];}//22

          try{
        if(temp["NOTLONGTXT"]["item"]!=null){h=temp["NOTLONGTXT"]["item"]["TEXT_LINE"]["_text"];
        }
        }catch(error){
          for (var items in temp["NOTLONGTXT"]["item"]){
            print(items["TEXT_LINE"]["_text"]);
            h+= items["TEXT_LINE"]["_text"];
          }
        }








        
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x);
        details.add(data);
      print(details.length);
      return details;
      }
      else{
      //  _showtoast(context, "Incorrect UserId / Password");
        var a="Not created";var b="NA";var c="NA"; var d="NA"; var e="NA";var f="0";var g="NA";
        var h="0";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="0";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "no";var t = "breakdown";var u = "no";
        var v = "breakdown";var w ="na";var x="na";
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x);
        details.add(data);
        return details;
      }

    }

    catch(error,stacktrace){
      print(error);
      print(stacktrace);
      var a="Not created";var b="NA";var c="NA"; var d="NA"; var e="NA";var f="0";var g="NA";
        var h="0";var i="NA";var j="NA";var k="NA";var l="NA";var m="NA";var n="0";
        var o = "na";var p = "na";var q = "na";var r = "na";var s = "no";var t = "breakdown";var u = "no";
        var v = "breakdown";var w ="na";var x="na";
        Notificationdetails data = Notificationdetails(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x);
        List<Notificationdetails> details = [];
        details.add(data);
        return details;

    }
  }
String removezero(String a){
  print(a);
  try{
  var temp = int.parse(a);
  //  print("$temp convertedd value");
  return temp.toString();
  }catch(error){return a;}
  //return a;
}