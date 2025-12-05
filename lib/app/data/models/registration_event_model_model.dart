class RegistrationEventModel {
  String? id;
  String? eventId;
  String? eventName;
  String? uid;
  String? name;
  String? imageProfile;
  String? createdAt;

  RegistrationEventModel(
      {this.id,
      this.eventId,
      this.eventName,
      this.uid,
      this.name,
      this.imageProfile,
      this.createdAt});

  RegistrationEventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    eventName = json['eventName'];
    uid = json['uid'];
    name = json['name'];
    imageProfile = json['imageProfile'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['eventId'] = eventId;
    data['eventName'] = eventName;
    data['uid'] = uid;
    data['name'] = name;
    data['imageProfile'] = imageProfile;
    data['createdAt'] = createdAt;
    return data;
  }
}
