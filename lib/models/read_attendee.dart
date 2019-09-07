class ReadAttendee{
 String name;
  String registrationNumber;
  String email;
  String phoneNumber;
  String gender;
  ReadAttendee({
    this.name,
    this.registrationNumber,
    this.email,
    this.phoneNumber,
    this.gender,
  });
  factory ReadAttendee.fromJson(Map<String,dynamic> json){
    return ReadAttendee(
      name: json["name"],
      registrationNumber: json["registrationNumber"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      gender: json["gender"],
    );
  }
}

// Future<List<readAttendee>> fetchreadAttendee(http.HttpClient client)async{
//   final response=await client.post(host, port, path)
// }
