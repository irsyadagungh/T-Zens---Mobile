class UserModel {
  String? email;
  String? faculty;
  String? major;
  String? name;
  String? nim;
  String? phone;
  String? role;
  String? uid;
  String? username;

  UserModel(
      {this.email,
      this.faculty,
      this.major,
      this.name,
      this.nim,
      this.phone,
      this.role,
      this.uid,
      this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    faculty = json['faculty'];
    major = json['major'];
    name = json['name'];
    nim = json['nim'];
    phone = json['phone'];
    role = json['role'];
    uid = json['uid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['faculty'] = faculty;
    data['major'] = major;
    data['name'] = name;
    data['nim'] = nim;
    data['phone'] = phone;
    data['role'] = role;
    data['uid'] = uid;
    data['username'] = username;
    return data;
  }
}
