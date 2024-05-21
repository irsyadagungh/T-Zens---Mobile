import 'package:tzens/app/data/models/user_model_model.dart';

class WebinarModel {
  UserModel? administrator;
  List<dynamic>? benefits;
  List<Contact>? contact;
  String? date;
  String? description;
  String? id;
  String? link;
  String? location;
  String? photo;
  List<dynamic>? prerequisite;
  List<dynamic>? registeredAccount;
  String? status;
  Time? time;
  String? title;
  String? createdAt;
  String? updatedAt;

  WebinarModel({
    this.administrator,
    this.benefits,
    this.contact,
    this.date,
    this.description,
    this.id,
    this.link,
    this.location,
    this.photo,
    this.prerequisite,
    this.registeredAccount,
    this.status,
    this.time,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  WebinarModel.fromJson(Map<String, dynamic> json) {
    administrator = json['administrator'] != null
        ? UserModel.fromJson(json['administrator'])
        : null;
    benefits = json['benefits'];
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
    prerequisite = json['prerequisite'];
    registeredAccount = List<String>.from(json['registeredAccount'] ?? []);
    status = json['status'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
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
    data['registeredAccount'] = registeredAccount;
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
