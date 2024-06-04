import 'package:tzens/app/data/models/user_model_model.dart';

class OrganizationModel {
  UserModel? administrator; // done
  List<Contact>? contact; // done
  String? createdAt; // done
  String? description; // Done
  List<String>? division; // Done
  String? link;
  OpenRecruitment? openRecruitment;
  String? photoUrl;
  List<RegisteredAccount>? registeredAccount;
  String? title;
  String? updatedAt;

  OrganizationModel(
      {this.administrator,
      this.contact,
      this.createdAt,
      this.description,
      this.division,
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
    division = json['division'].cast<String>();
    link = json['link'];
    openRecruitment = json['open_recruitment'] != null
        ? OpenRecruitment?.fromJson(json['open_recruitment'])
        : null;
    photoUrl = json['photoUrl'];
    if (json['registered_account'] != null) {
      registeredAccount = <RegisteredAccount>[];
      json['registered_account'].forEach((v) {
        registeredAccount?.add(RegisteredAccount.fromJson(v));
      });
    }
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
    data['link'] = link;
    if (openRecruitment != null) {
      data['open_recruitment'] = openRecruitment?.toJson();
    }
    data['photoUrl'] = photoUrl;
    if (registeredAccount != null) {
      data['registered_account'] =
          registeredAccount?.map((v) => v.toJson()).toList();
    }
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

class RegisteredAccount {
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

  RegisteredAccount(
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

  RegisteredAccount.fromJson(Map<String, dynamic> json) {
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
