import 'package:tzens/app/data/models/user_model_model.dart';

class OrganizationModel {
  String? title;
  String? link;
  OpenRecruitment? openRecruitment;
  String? description;
  String? photoUrl;
  List<UserModel>? registeredAccount;
  List<String>? division;

  OrganizationModel(
      {this.title,
      this.link,
      this.openRecruitment,
      this.description,
      this.photoUrl,
      this.registeredAccount,
      this.division});

  OrganizationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    openRecruitment = json['open_recruitment'] != null
        ? OpenRecruitment?.fromJson(json['open_recruitment'])
        : null;
    description = json['description'];
    photoUrl = json['photoUrl'];
    if (json['registered_account'] != null) {
      registeredAccount = <UserModel>[];
      json['registered_account'].forEach((v) {
        registeredAccount?.add(UserModel.fromJson(v));
      });
    }
    division = json['division'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    if (openRecruitment != null) {
      data['open_recruitment'] = openRecruitment?.toJson();
    }
    data['description'] = description;
    data['photoUrl'] = photoUrl;
    if (registeredAccount != null) {
      data['registered_account'] =
          registeredAccount?.map((v) => v.toJson()).toList();
    }
    data['division'] = division;
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