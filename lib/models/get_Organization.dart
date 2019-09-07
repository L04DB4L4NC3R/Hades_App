import 'package:hade/models/organization.dart' as prefix0;

class Data{
  List<Organization> organization;

  Data({this.organization});

   factory Data.fromJson(Map<String, dynamic> json){
    var list = json["organizations"] as List;
    List<Organization> requestedList = list.map((i) => Organization.fromJson(i)).toList();
    return Data(
     organization: requestedList
    );
  }
}
class Organization{
  String name;
  String location;
  String description;
  String tag;
  String website;
  Organization({this.description,this.location,this.name,this.tag,this.website});

factory Organization.fromJson(Map<String,dynamic> json){
    return Organization(
name: json["name"],
location: json["location"],
description: json["description"],
tag: json["tag"],
website: json["website"]
    );

}
}