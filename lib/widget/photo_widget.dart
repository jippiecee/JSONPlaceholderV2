
import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/photos.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photo;
  const PhotoWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF7F5F9),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              photo.thumbnailUrl,
              width: 64,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 64,
                  height: 52,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          title: Text(
            photo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'ID: #${photo.id}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Album ID: ${photo.albumId}',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
