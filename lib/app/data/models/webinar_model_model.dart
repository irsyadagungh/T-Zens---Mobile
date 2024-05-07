import 'package:tzens/app/data/models/user_model_model.dart';

class WebinarModel {
  UserModel? administrator;
  List<String>? benefits;
  List<Contact>? contact;
  String? date;
  String? description;
  String? id;
  String? link;
  String? location;
  String? photo;
  List<String>? prerequisite;
  String? status;
  Time? time;
  String? title;
  String? createdAt;
  String? updatedAt;

  WebinarModel(
      {this.administrator,
      this.benefits,
      this.contact,
      this.date,
      this.description,
      this.id,
      this.link,
      this.location,
      this.photo,
      this.prerequisite,
      this.status,
      this.time,
      this.title,
      this.createdAt,
      this.updatedAt});

  WebinarModel.fromJson(Map<String, dynamic> json) {
    administrator = json['administrator'] != null
        ? UserModel?.fromJson(json['administrator'])
        : null;
    benefits = json['benefits'].cast<String>();
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact?.add(Contact.fromJson(v));
      });
    }
    date = json['date'];
    description = json['description'];
    id = json['id'];
    link = json['link'];
    location = json['location'];
    photo = json['photo'];
    prerequisite = json['prerequisite'].cast<String>();
    status = json['status'];
    time = json['time'] != null ? Time?.fromJson(json['time']) : null;
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (administrator != null) {
      data['administrator'] = administrator?.toJson();
    }
    data['benefits'] = benefits;
    if (contact != null) {
      data['contact'] = contact?.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    data['description'] = description;
    data['id'] = id;
    data['link'] = link;
    data['location'] = location;
    data['photo'] = photo;
    data['prerequisite'] = prerequisite;
    data['status'] = status;
    if (time != null) {
      data['time'] = time?.toJson();
    }
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Administrator {
  String? email;
  String? faculty;
  String? major;
  String? name;
  String? nim;
  String? phone;
  String? role;
  String? uid;
  String? username;
  String? photo;

  Administrator(
      {this.email,
      this.faculty,
      this.major,
      this.name,
      this.nim,
      this.phone,
      this.role,
      this.uid,
      this.username,
      this.photo});

  Administrator.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    faculty = json['faculty'];
    major = json['major'];
    name = json['name'];
    nim = json['nim'];
    phone = json['phone'];
    role = json['role'];
    uid = json['uid'];
    username = json['username'];
    photo = json['photo'];
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
    data['photo'] = photo;
    return data;
  }
}

class Contact {
  String? name;
  String? phone;

  Contact({this.name, this.phone});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}

class Time {
  String? endTime;
  String? startTime;

  Time({this.endTime, this.startTime});

  Time.fromJson(Map<String, dynamic> json) {
    endTime = json['endTime'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['endTime'] = endTime;
    data['startTime'] = startTime;
    return data;
  }
}
