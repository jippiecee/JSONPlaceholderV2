import 'package:flutter/material.dart';
import 'package:jsonplaceholder/tab/comments_tab.dart';
import 'package:jsonplaceholder/tab/post_tab.dart';
import 'package:jsonplaceholder/tab/photos_tab.dart';
import 'package:jsonplaceholder/tab/albums_tab.dart';
import 'package:jsonplaceholder/tab/todos_tab.dart';
import 'package:jsonplaceholder/tab/users_tab.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JsonPlaceholder API'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Posts', icon: Icon(Icons.article)),
              Tab(text: 'Photos', icon: Icon(Icons.photo)),
              Tab(text: 'Comments', icon: Icon(Icons.comment)),
              Tab(text: 'Album', icon: Icon(Icons.photo_library)),
              Tab(text: 'Todos', icon: Icon(Icons.check_circle_outline)),
              Tab(text: 'User', icon: Icon(Icons.people)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PostTab(),
            PhotosTab(),
            CommentTab(),
            AlbumsTab(),
            TodosTab(),
            UsersTab(),
          ],
        ),
      ),
    );
  }
}