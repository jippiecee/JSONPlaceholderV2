
import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 1,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      user.name[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text('@${user.username}'),
                      ],
                    ),
                  ),
                  Text('ID: ${user.id}'),
                ],
              ),
              const Divider(height: 24),
              Text('Email: ${user.email}'),
              const SizedBox(height: 6),
              Text('Phone: ${user.phone}'),
              const SizedBox(height: 6),
              Text('Website: ${user.website}'),
              const SizedBox(height: 6),
              Text('Address: ${user.address.street}, ${user.address.city}'),
              const SizedBox(height: 6),
              Text('Company: ${user.company.name}'),
              const SizedBox(height: 6),
              Text(
                'Description: ${user.company.catchPhrase}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
