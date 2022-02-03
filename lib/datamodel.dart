import 'dart:convert';

class datamodel{
  final String mobile_number;
  final String name;



  datamodel({this.mobile_number,this.name});

  factory datamodel.fromJson(final json){
  return datamodel(
      mobile_number: json["mobile_number"],
      name:json["name"]
      );
}
}
