import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/comments.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/comment_widget.dart';

class CommentTab extends StatelessWidget {
  const CommentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Comments>(
      title: 'Comments',
      onFetch: ApiService.fetchComments,
      itemBuilder: (context, comment, index) =>
          CommentWidget(comment: comment),
    );
  }
}