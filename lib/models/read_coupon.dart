class ReadCoupon{
 String name;
  String description;
  int day;
  ReadCoupon({
    this.name,
    this.description,
    this.day,
  });
  factory ReadCoupon.fromJson(Map<String,dynamic> json){
    return ReadCoupon(
      name: json["name"],
      description: json["description"],
      day: json["day"],
      
    );
  }
}

// Future<List<readAttendee>> fetchreadAttendee(http.HttpClient client)async{
//   final response=await client.post(host, port, path)
// }
