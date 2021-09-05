class Users {
  String uid;
  String name;
  String age;
  String simNumber;
  String registrationId;
  String address;
  Users({
     this.uid,
     this.name,
     this.age,
     this.simNumber,
     this.registrationId,
     this.address
  });

  Users.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    age = json['age'];
    simNumber = json['simNumber'];
    registrationId = json['registrationId'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['name'] = this.name;
    data['age'] = this.age;
    data['simNumber'] = this.simNumber;
    data['registrationId'] = this.registrationId;
    data['address'] = this.address;

    return data;
  }
}