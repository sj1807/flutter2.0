import 'dart:convert';
import 'package:flutter/material.dart';
import './main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'package:json_annotation/json_annotation.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}//creating a state

class _State extends State<LoginPage>{

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  httplogin(String name, String pass) async {
    print('$name, from function $pass');
    var uri =  Uri.parse("$baseUrl/emp/login");
    try{
      final response = await http.post(uri,
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String,String>{
            'user' : '$name',
            'pass' : '$pass',
          }),
      );
      final resp = jsonDecode(response.body);
      print(resp["status"]);
      if(resp["status"]=='1'){
        print("ok user");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("user", name);
        sessionuser = name;
        Navigator.pushReplacementNamed(context, '/home');
      }
      else{
        _showtoast(context, "Incorrect UserId / Password");

      }
    }

    catch(error){
      print(error);
    }
  }
   
   
    void _showtoast(BuildContext context, String a) {
    //print(logger);
    final scaffold= ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content:  Text("$a"))
    );
  }

  @override



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset('assets/logo.jpg',
            fit: BoxFit.contain,
            height:32),
            Container(padding: const EdgeInsets.all(8.0), child: Text('Maintenance Portal'))
          ]
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child:  Text ('Maintenance Engineer Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ))
            ),//headingcontainer
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/maint.png',height:100),
            ),//imagecontainer
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Id',
                  prefixIcon: Icon(Icons.account_circle)
                  
                )
              ),
            ),//userid container
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)
                )
              ),
            ),//password container
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed:(){
                    if(nameController.text=="" || passwordController.text ==""){
                      _showtoast(context, "Enter a valid usename and password");
                    }else{
                      httplogin(nameController.text,passwordController.text);
                    } 
                  },//press
                )
            )
          ],
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          "\nPowered by Firebase. \nCopyright ©2021, All Rights Reserved.\n",
          textAlign: TextAlign.center,
        ),
        color: Colors.blueAccent
      ),
    );//scaffold
  }//widget build

}//_state class