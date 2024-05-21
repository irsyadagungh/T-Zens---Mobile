class UserModel {
  List<String>? bookmark;
  String? email;
  String? faculty;
  String? major;
  String? name;
  String? nim;
  String? phone;
  List<String>? registeredWebinar;
  String? role;
  String? uid;
  String? username;
  String? photoUrl;
  String? token;

  UserModel(
      {this.bookmark,
      this.email,
      this.faculty,
      this.major,
      this.name,
      this.nim,
      this.phone,
      this.registeredWebinar,
      this.role,
      this.uid,
      this.username,
      this.photoUrl,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    bookmark = json['bookmark'];
    email = json['email'];
    faculty = json['faculty'];
    major = json['major'];
    name = json['name'];
    nim = json['nim'];
    phone = json['phone'];
    registeredWebinar = json['registeredWebinar'];
    role = json['role'];
    uid = json['uid'];
    username = json['username'];
    photoUrl = json['photoUrl'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bookmark'] = bookmark;
    data['email'] = email;
    data['faculty'] = faculty;
    data['major'] = major;
    data['name'] = name;
    data['nim'] = nim;
    data['phone'] = phone;
    data['registeredWebinar'] = registeredWebinar;
    data['role'] = role;
    data['uid'] = uid;
    data['username'] = username;
    data['photoUrl'] = photoUrl;
    data['token'] = token;
    return data;
  }
}
