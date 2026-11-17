import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/photos.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photo;
  const PhotoWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.network(
          photo.thumbnailUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(photo.title),
        subtitle: Text('ID FOto: ${photo.id}'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}