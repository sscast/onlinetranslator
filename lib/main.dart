import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translatetest/post.dart';
import 'package:translatetest/translate.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() {
  configureApp();
  runApp(ProviderScope(child: MyApp()));
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
        fontFamily: 'Noto',
        backgroundColor: Colors.blue,
      ),
      home: TranslatePage(
        post: post,
      ),
    );
  }
}
