import 'package:tzens/app/data/models/user_model_model.dart';

class OrganizationModel {
  UserModel? administrator;
  List<Contact>? contact;
  String? createdAt;
  String? description;
  List<dynamic>? division;
  String? id;
  String? link;
  OpenRecruitment? openRecruitment;
  String? photoUrl;
  List<dynamic>? registeredAccount;
  String? title;
  String? updatedAt;

  OrganizationModel(
      {this.administrator,
      this.contact,
      this.createdAt,
      this.description,
      this.division,
      this.id,
      this.link,
      this.openRecruitment,
      this.photoUrl,
      this.registeredAccount,
      this.title,
      this.updatedAt});

  OrganizationModel.fromJson(Map<String, dynamic> json) {
    administrator = json['administrator'] != null
        ? UserModel?.fromJson(json['administrator'])
        : null;
    if (json['contact'] != null) {
      contact = <Contact>[];
      json['contact'].forEach((v) {
        contact?.add(Contact.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    description = json['description'];
    division = json['division'];
    id = json['id'];
    link = json['link'];
    openRecruitment = json['open_recruitment'] != null
        ? OpenRecruitment?.fromJson(json['open_recruitment'])
        : null;
    photoUrl = json['photoUrl'];
    registeredAccount = json['registered_account'];
    title = json['title'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (administrator != null) {
      data['administrator'] = administrator?.toJson();
    }
    if (contact != null) {
      data['contact'] = contact?.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['division'] = division;
    data['id'] = id;
    data['link'] = link;
    if (openRecruitment != null) {
      data['open_recruitment'] = openRecruitment?.toJson();
    }
    data['photoUrl'] = photoUrl;
    data['registered_account'] = registeredAccount;
    data['title'] = title;
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

class OpenRecruitment {
  String? startDate;
  String? endDate;

  OpenRecruitment({this.startDate, this.endDate});

  OpenRecruitment.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
