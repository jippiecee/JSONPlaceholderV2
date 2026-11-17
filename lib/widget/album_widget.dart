import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/albums.dart';

class AlbumWidget extends StatelessWidget {
  final Albums album;
  const AlbumWidget({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.photo_album, color: Colors.cyanAccent,),
        title: Text(album.title),
        subtitle: Text('Album ${album.id} User : ${album.userId}'),
      ),
    );
  }
}