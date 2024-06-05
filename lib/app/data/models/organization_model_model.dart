import 'package:tzens/app/data/models/user_model_model.dart';

class OrganizationModel {
  UserModel? administrator;
  List<Contact>? contact;
  String? createdAt;
  String? description;
  List<String>? division;
  String? id;
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
    division = json['division'].cast<String>();
    id = json['id'];
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
    data['id'] = id;
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

class Administrator {
  List<String>? bookmark;
  String? email;
  String? faculty;
  String? major;
  String? name;
  String? nim;
  String? phone;
  List<String>? registeredWebinar;
  String? role;
  String? token;
  String? uid;
  String? username;
  String? photoUrl;

  Administrator(
      {this.bookmark,
      this.email,
      this.faculty,
      this.major,
      this.name,
      this.nim,
      this.phone,
      this.registeredWebinar,
      this.role,
      this.token,
      this.uid,
      this.username,
      this.photoUrl});

  Administrator.fromJson(Map<String, dynamic> json) {
    bookmark = json['bookmark'].cast<String>();
    email = json['email'];
    faculty = json['faculty'];
    major = json['major'];
    name = json['name'];
    nim = json['nim'];
    phone = json['phone'];
    registeredWebinar = json['registeredWebinar'].cast<String>();
    role = json['role'];
    token = json['token'];
    uid = json['uid'];
    username = json['username'];
    photoUrl = json['photoUrl'];
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
    data['token'] = token;
    data['uid'] = uid;
    data['username'] = username;
    data['photoUrl'] = photoUrl;
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
  String? photoUrl;

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
      this.photoUrl});

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
    photoUrl = json['photo'];
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
    data['photo'] = photoUrl;
    return data;
  }
}
