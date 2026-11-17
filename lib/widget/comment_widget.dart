import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: ClipRect(child: Text('${comment.id}')),
        title: Text(comment.name),
        subtitle: Text('${comment.email}\n${comment.body}'),
        isThreeLine: true,
      ),
    );
  }
}