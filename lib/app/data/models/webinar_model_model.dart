import 'package:tzens/app/data/models/user_model_model.dart';

class WebinarModel {
  UserModel? administrator;
  List<String>? benefits;
  List<Contact>? contact;
  String? description;
  String? id;
  String? location;
  String? photo;
  List<String>? prerequisite;
  String? title;
  String? createdAt;
  String? updatedAt;

  WebinarModel(
      {this.administrator,
      this.benefits,
      this.contact,
      this.description,
      this.id,
      this.location,
      this.photo,
      this.prerequisite,
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
    description = json['description'];
    id = json['id'];
    location = json['location'];
    photo = json['photo'];
    prerequisite = json['prerequisite'].cast<String>();
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
    data['description'] = description;
    data['id'] = id;
    data['location'] = location;
    data['photo'] = photo;
    data['prerequisite'] = prerequisite;
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
