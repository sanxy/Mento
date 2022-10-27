class MentoModel {
  String? topicName;
  List<String>? concepts;
  String? error;

  MentoModel({this.topicName, this.concepts});

  MentoModel.withError(String errorMessage) {
    error = errorMessage;
  }

  MentoModel.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    concepts = json['concepts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['topicName'] = topicName;
    data['concepts'] = concepts;
    return data;
  }
}
