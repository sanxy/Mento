class User {
  String? topicName;
  List<String>? concepts;

  User({this.topicName, this.concepts});

  User.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    concepts = json['concepts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicName'] = topicName;
    data['concepts'] = concepts;
    return data;
  }
}
