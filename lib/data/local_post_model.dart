class LocalPostModel {
  final String title;
  final String body;

  LocalPostModel({required this.title, required this.body});

  Map<String, dynamic> toJson() => {'title': title, 'body': body};
  factory LocalPostModel.fromJson(Map<String, dynamic> json) =>
      LocalPostModel(title: json['title'], body: json['body']);
}
