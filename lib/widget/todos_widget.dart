import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/todos.dart';

class TodosWidget extends StatelessWidget {
  final Todos todo;
  final VoidCallback? onTap;

  const TodosWidget({super.key, required this.todo, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final done = todo.completed;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      elevation: 0,
      color: done
          ? colorScheme.surfaceContainerLow
          : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: done
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest,
          foregroundColor: done
              ? colorScheme.onPrimaryContainer
              : colorScheme.onSurfaceVariant,
          child: Icon(
            done ? Icons.check_rounded : Icons.schedule_rounded,
            size: 20,
          ),
        ),
        title: Text(
          todo.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            decoration: done ? TextDecoration.lineThrough : null,
            color: done ? colorScheme.onSurfaceVariant : colorScheme.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: done
                      ? colorScheme.primaryContainer.withValues(alpha: 0.7)
                      : colorScheme.secondaryContainer.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  done ? 'Selesai' : 'Belum selesai',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: done
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                'Todo #${todo.id} · User ${todo.userId}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}