import 'package:flutter/material.dart';
import 'package:jsonplaceholder/tab/albums_tab.dart';
import 'package:jsonplaceholder/tab/comments_tab.dart';
import 'package:jsonplaceholder/tab/photos_tab.dart';
import 'package:jsonplaceholder/tab/post_tab.dart';
import 'package:jsonplaceholder/tab/todos_tab.dart';
import 'package:jsonplaceholder/tab/users_tab.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Posts',
      icon: Icons.article_outlined,
      activeIcon: Icons.article,
      child: PostTab(),
    ),
    _NavItem(
      label: 'Photos',
      icon: Icons.photo_outlined,
      activeIcon: Icons.photo,
      child: PhotosTab(),
    ),
    _NavItem(
      label: 'Comments',
      icon: Icons.comment_outlined,
      activeIcon: Icons.comment,
      child: CommentTab(),
    ),
    _NavItem(
      label: 'Albums',
      icon: Icons.photo_library_outlined,
      activeIcon: Icons.photo_library,
      child: AlbumsTab(),
    ),
    _NavItem(
      label: 'Todos',
      icon: Icons.check_circle_outline,
      activeIcon: Icons.check_circle,
      child: TodosTab(),
    ),
    _NavItem(
      label: 'Users',
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      child: UsersTab(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: _items.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          titleSpacing: 20,
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                child: const Icon(Icons.api_rounded, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'JSONPlaceholder API',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'REST Resource Explorer',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(54),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: colorScheme.onPrimaryContainer,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    labelStyle: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: theme.textTheme.labelLarge,
                    tabs: _items
                        .map(
                          (item) => Tab(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(item.icon, size: 18),
                                  const SizedBox(width: 8),
                                  Text(item.label),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: colorScheme.outlineVariant.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: TabBarView(
              children: _items.map((item) => item.child).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final Widget child;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.child,
  });
}