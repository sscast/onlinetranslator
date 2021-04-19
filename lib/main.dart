import 'package:flutter/material.dart';
import 'package:translatetest/post.dart';
import 'package:translatetest/translate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Post post = Post(
        postId: "123456",
        uid: "user012",
        title: "",
        content: "",
        translated: "");
    return MaterialApp(
      title: "Online Translator",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Noto',
      ),
      home: TranslatePage(
        post: post,
      ),
    );
  }
}
