import 'package:flutter/material.dart';
import 'package:jsonplaceholder/tab/post_tab.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JsonPlaceholder API'),
          bottom: const TabBar(tabs: [Tab(text: 'Posts')]),
        ),
        body: const TabBarView(children: [PostTab()]),
      ),
    );
  }
}