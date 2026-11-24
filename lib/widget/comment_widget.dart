import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;
  final VoidCallback? onTap;

  const CommentWidget({super.key, required this.comment, this.onTap});

  static const List<Color> _palette = [
    Color(0xFF006874),
    Color(0xFF4A6267),
    Color(0xFF525E7D),
    Color(0xFF6B5778),
    Color(0xFF7B5436),
    Color(0xFF386A20),
  ];

  Color _avatarColor(String seed) {
    final hash = seed.codeUnits.fold<int>(0, (acc, c) => acc + c);
    return _palette[hash % _palette.length];
  }

  String _initials(String name, String email) {
    final source = name.trim().isNotEmpty ? name.trim() : email.trim();
    final parts = source.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return source.substring(0, source.length.clamp(1, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final avatarColor = _avatarColor(comment.email);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: avatarColor,
          foregroundColor: Colors.white,
          child: Text(
            _initials(comment.name, comment.email),
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                comment.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '#${comment.id}',
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                comment.body.replaceAll('\n', ' '),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}