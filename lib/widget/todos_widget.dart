import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/todos.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/widget/app_card.dart';

class TodosWidget extends StatelessWidget {
  final Todos todo;
  const TodosWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final done = todo.completed;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? AppColors.todos : Colors.transparent,
              border: Border.all(
                color: done ? AppColors.todos : const Color(0xFFD1D5DB),
                width: 2,
              ),
            ),
            child: done
                ? const Icon(Icons.check, size: 15, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              todo.title,
              style: TextStyle(
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w500,
                color: done ? AppColors.subtle : AppColors.ink,
                decoration: done ? TextDecoration.lineThrough : null,
                decorationColor: AppColors.subtle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Pill(
            done ? 'Selesai' : 'Belum',
            color: done ? AppColors.todos : AppColors.muted,
          ),
        ],
      ),
    );
  }
}