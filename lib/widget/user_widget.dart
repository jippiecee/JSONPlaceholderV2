import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name[0]),),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('@${user.name}'),
            Text(user.email),
            Text(user.phone),
            Text('${user.address.city} | ${user.company}'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}