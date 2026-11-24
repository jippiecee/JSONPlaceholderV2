import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/albums.dart';

class AlbumWidget extends StatelessWidget {
  final Albums album;
  final VoidCallback? onTap;

  const AlbumWidget({super.key, required this.album, this.onTap});

  static const List<Color> _userColors = [
    Color(0xFF006874),
    Color(0xFF4A6267),
    Color(0xFF525E7D),
    Color(0xFF6B5778),
    Color(0xFF7B5436),
    Color(0xFF386A20),
  ];

  Color _colorForUser(int userId) {
    final index = (userId.abs() - 1) % _userColors.length;
    return _userColors[index];
  }

  String _initialsFromTitle(String title) {
    final words = title
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return '#${album.id}';
    if (words.length == 1) {
      return words.first.substring(0, words.first.length.clamp(1, 2)).toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = _colorForUser(album.userId);
    final initials = _initialsFromTitle(album.title);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          child: Text(
            initials,
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Text(
          album.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _MetaBadge(
                icon: Icons.photo_album_outlined,
                label: 'Album #${album.id}',
                colorScheme: theme.colorScheme,
              ),
              _MetaBadge(
                icon: Icons.person_outline,
                label: 'User ${album.userId}',
                colorScheme: theme.colorScheme,
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const _MetaBadge({
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}