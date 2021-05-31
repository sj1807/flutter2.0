import 'package:flutter/material.dart';

class Sessionlog extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text("Session Log")
      ),
      body: 
      Container(
        child: sessionlog.length <1 ? 
        Center(
          child: Text('No  activities')
        )
        :
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(15),
          physics: ClampingScrollPhysics(),
          itemCount: sessionlog.length,
          itemBuilder: (BuildContext ctxt, int index){
            return new Text('${index + 1} : ${sessionlog[index].log}\n');
          }

      ),
    ));
  }
}




class Logs{
    final String log;
    Logs(this.log); 
}
List<Logs> sessionlog = [];
