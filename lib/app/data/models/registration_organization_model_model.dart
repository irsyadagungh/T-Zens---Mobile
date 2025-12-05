class RegistrationOrganizationModel {
  String? id;
  String? organizationId;
  String? organizationName;
  String? uid;
  String? name;
  String? createdAt;

  RegistrationOrganizationModel(
      {this.id,
      this.organizationId,
      this.organizationName,
      this.uid,
      this.name,
      this.createdAt});

  RegistrationOrganizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    uid = json['uid'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['organizationId'] = organizationId;
    data['organizationName'] = organizationName;
    data['uid'] = uid;
    data['name'] = name;
    data['createdAt'] = createdAt;
    return data;
  }
}
