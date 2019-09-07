class Requests{
  List<Organization> requested;
  Requests({this.requested});

  factory Requests.fromJson(Map<String, dynamic> json){
    var list = json["data"] as List;
    List<Organization> requestedList = list.map((i) => Organization.fromJson(i)).toList();
    return Requests(
      requested: requestedList
    );
  }

}

class Organization {
  String id;
  String fullName;
  String location;
  String photoUrl;
  String description;
  int v;

  Organization(
      {this.v, this.id, this.description, this.fullName, this.location,this.photoUrl});


  factory Organization.fromJson(Map<String, dynamic> json){
    return Organization(
        fullName: json["name"],
        location: json["location"],
        photoUrl: json["tag"],
        description: json["description"],
      
    );
  }
}