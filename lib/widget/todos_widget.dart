import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/todos.dart';

class TodosWidget extends StatelessWidget {
  final Todos todo;
  const TodosWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          todo.completed ? Icons.check_box : Icons.radio_button_unchecked,
          color: todo.completed ? Colors.green : Colors.grey,
        ), 
        title: Text(todo.title),
        subtitle: Text(todo.completed ? 'Selesai' : 'Belum selesai'),
      ),
    );
  }
}