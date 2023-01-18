

class UserData  {
  String? name;
  String? age;
  String? email;
  String? profilePicUrl;
  String? id;


  UserData(
      {this.name,
        this.age='20',
        this.email,
        this.profilePicUrl,
        this.id,
      });

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    email = json['email'];
    profilePicUrl = json['profilePicUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['email'] = this.email;
    data['profilePicUrl'] = this.profilePicUrl;
    data['id'] = this.id;
    return data;
  }
}
