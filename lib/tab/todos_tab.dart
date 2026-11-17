import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/todos.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/todos_widget.dart';

class TodosTab extends StatelessWidget {
  const TodosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Todos>(
      title: 'Photos',
      onFetch: ApiService.fetchTodos,
      itemBuilder: (context, todo, index) => TodosWidget(todo: todo),
    );
  }
}