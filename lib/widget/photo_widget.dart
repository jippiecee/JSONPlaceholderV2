import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/photos.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/widget/app_card.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photo;
  const PhotoWidget({super.key, required this.photo});

  // Ambil warna dari hex di akhir URL thumbnail (contoh: .../150/92c952)
  Color get _tint {
    final hex = photo.thumbnailUrl.split('/').last;
    final v = int.tryParse(hex, radix: 16);
    if (hex.length == 6 && v != null) return Color(0xFF000000 | v);
    return AppColors.skeleton;
  }

  Widget _placeholder({bool withIcon = true}) {
    return Container(
      color: _tint,
      alignment: Alignment.center,
      child: withIcon
          ? const Icon(Icons.image_outlined, color: Colors.white70, size: 34)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                photo.thumbnailUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) =>
                    progress == null ? child : _placeholder(withIcon: false),
                errorBuilder: (context, error, stackTrace) => _placeholder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Album ${photo.albumId} · #${photo.id}',
                  style: const TextStyle(fontSize: 11.5, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}