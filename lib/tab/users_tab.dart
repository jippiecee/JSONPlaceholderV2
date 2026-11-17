import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/users.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/user_widget.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Users>(
      title: 'User',
      onFetch: ApiService.fetchUsers,
      itemBuilder: (context, user, index) => UserWidget(user: user,)
    );
  }
}