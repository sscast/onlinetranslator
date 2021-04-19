import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Post extends Equatable {
  final String postId;
  final String uid;
  final String category;
  final String location;
  final String date;
  final String title;
  final String content;
  final String translated;

  @override
  List<Object> get props => [
        postId,
        uid,
        category,
        location,
        title,
        date,
        content,
        translated,
      ];
  @override
  bool get stringify => true;

  Post({
    this.postId,
    this.uid,
    this.category,
    this.location,
    this.date,
    this.title,
    this.content,
    this.translated,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      postId: doc['postId'],
      uid: doc['uid'],
      category: doc['category'],
      location: doc['location'],
      title: doc['title'],
      date: doc['date'],
      content: doc['content'],
      translated: doc['translated'],
    );
  }

  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final postId = data['postId'];
    final String uid = data['uid'];
    final String category = data['category'];
    final String location = data['location'];
    String date = data['date'];
    String title = data['title'];
    String content = data['content'];
    String translated = data['translated'];

    return Post(
      postId: postId,
      uid: uid,
      category: category,
      location: location,
      title: title,
      date: date,
      content: content,
      translated: translated,
    );
  }

  int getLikeCount(likes) {
    if (likes == {}) {
      return 0;
    }

    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "uid": uid,
      "category": category,
      "date": date,
      "location": location,
      "title": title,
      "content": content,
      "translated": translated,
    };
  }
}
