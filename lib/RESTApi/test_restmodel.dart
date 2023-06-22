class Post {
  final int? userId;
  final int? id;
  final String? title;

  Post({this.userId, this.id, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['groupName'],
      //description: json[' description'],
    );
  }
}
