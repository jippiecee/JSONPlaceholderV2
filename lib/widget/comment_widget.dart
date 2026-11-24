import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/comments.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/widget/app_card.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final initial =
        comment.email.isNotEmpty ? comment.email[0].toUpperCase() : '?';

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.comments.withValues(alpha: 0.12),
            child: Text(
              initial,
              style: const TextStyle(
                color: AppColors.comments,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  comment.email,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.comments,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  comment.body,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}