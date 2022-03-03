class PostModel {
  int? id;
  String? title;
  String? text;
  String? document;
  String? documentResized;
  String? user;
  bool? privacy;

  PostModel(
      {this.id,
      this.title,
      this.text,
      this.document,
      this.documentResized,
      this.user,
      this.privacy});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    document = json['document'];
    documentResized = json['documentResized'];
    user = json['user'];
    privacy = json['privacy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    data['document'] = document;
    data['documentResized'] = documentResized;
    data['user'] = user;
    data['privacy'] = privacy;
    return data;
  }
}
