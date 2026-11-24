import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/photos.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photo;
  final VoidCallback? onTap;

  const PhotoWidget({super.key, required this.photo, this.onTap});

  static const List<Color> _albumColors = [
    Color(0xFF006874),
    Color(0xFF4A6267),
    Color(0xFF525E7D),
    Color(0xFF6B5778),
    Color(0xFF7B5436),
    Color(0xFF386A20),
  ];

  Color _colorForAlbum(int albumId) {
    final index = (albumId.abs() - 1) % _albumColors.length;
    return _albumColors[index];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final albumColor = _colorForAlbum(photo.albumId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: SizedBox(
            width: 64,
            height: 52,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                photo.thumbnailUrl,
                width: 64,
                height: 52,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: albumColor.withValues(alpha: 0.14),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: albumColor,
                      foregroundColor: Colors.white,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          title: Text(
            photo.title,
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
                _PhotoBadge(
                  icon: Icons.tag,
                  label: 'Photo #${photo.id}',
                  colorScheme: colorScheme,
                ),
                _PhotoBadge(
                  icon: Icons.photo_album_outlined,
                  label: 'Album ${photo.albumId}',
                  colorScheme: colorScheme,
                ),
              ],
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _PhotoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const _PhotoBadge({
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