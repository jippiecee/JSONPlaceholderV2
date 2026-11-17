import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/post.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/post_widget.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Post>(
      title: 'Posts',
      onFetch: ApiService.fetchPosts,
      itemBuilder: (context, post, index) => PostWidget(post: post),
    );
  }
}