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
          bottom: const TabBar(tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Photos'),
            Tab(text: 'Comments'),
            Tab(text: 'Album'),
            Tab(text: 'Todos'),
            Tab(text: 'User'),
            ]),
        ),
        body: const TabBarView(children: [
          PostTab(),
          PhotosTab(),
          CommentTab(),
          AlbumsTab(),
          TodosTab(),
          UsersTab(),
          ]),
      ),
    );
  }
}