import 'package:flutter/material.dart';
import 'package:jsonplaceholder/tab/comments_tab.dart';
import 'package:jsonplaceholder/tab/post_tab.dart'; 
import 'package:jsonplaceholder/tab/photos_tab.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JsonPlaceholder API'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Photos'),
            Tab(text: 'Comments'),
            ]),
        ),
        body: const TabBarView(children: [
          PostTab(),
          PhotosTab(),
          CommentTab(),
          ]),
      ),
    );
  }
}