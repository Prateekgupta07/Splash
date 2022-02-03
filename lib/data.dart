import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'datamodel.dart';

class DataWidget extends StatefulWidget {
  String phone,otp;
  DataWidget({Key key,@required this.phone,this.otp, }) : super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState(phone,otp);
}

class _DataWidgetState extends State<DataWidget> {
  String phone,otp;
  _DataWidgetState(this.phone,this.otp);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
          child: FutureBuilder<datamodel>(
        future: getdata(phone,otp),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if(data.mobile_number=="7777777777"){
              print("Message: ${data.mobile_number}");
              return Text("${data.name} is verified");}
            else
              return Text(" error");


            print("Message: ${data.mobile_number}");

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}

Future<datamodel> getdata(String phone, String otp) async {
  try {
    print(phone);
    print(otp);
    final response = await http.post(Uri.https('startuptest.tech','/api/auth/client/login'),body: {
          "mobile_number": phone,
          "otp" : otp
        });
    final jsondata = jsonDecode(response.body);
    return datamodel.fromJson(jsondata);
  } catch (e) {
    print(e);
  }
}
