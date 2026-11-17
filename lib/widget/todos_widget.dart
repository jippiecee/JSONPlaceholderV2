import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/todos.dart';

class TodosWidget extends StatelessWidget {
  final Todos todo;
  const TodosWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal:  12, vertical: 6),
      child: ListTile(
        leading: Icon(
          todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: todo.completed ? Colors.green : Colors.grey,
        ),
        title: Text(todo.title),
        subtitle: Text(todo.completed ? 'selesai' : 'belum selesai'),
      ),
    );
  }
}