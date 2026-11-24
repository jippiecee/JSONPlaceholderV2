import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/albums.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/widget/app_card.dart';

class AlbumWidget extends StatelessWidget {
  final Albums album;
  const AlbumWidget({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const IconTile(
            icon: Icons.photo_library_outlined,
            color: AppColors.albums,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Pill('Album #${album.id}', color: AppColors.albums),
                    const SizedBox(width: 8),
                    Text(
                      'User ${album.userId}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}