import 'package:flutter/material.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/tab/comments_tab.dart';
import 'package:jsonplaceholder/tab/post_tab.dart';
import 'package:jsonplaceholder/tab/photos_tab.dart';
import 'package:jsonplaceholder/tab/albums_tab.dart';
import 'package:jsonplaceholder/tab/todos_tab.dart';
import 'package:jsonplaceholder/tab/users_tab.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  static const _tabs = [
    (Icons.article_outlined, 'Posts'),
    (Icons.photo_outlined, 'Photos'),
    (Icons.chat_bubble_outline, 'Comments'),
    (Icons.photo_library_outlined, 'Albums'),
    (Icons.check_circle_outline, 'Todos'),
    (Icons.people_outline, 'Users'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'JSONPlaceholder',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.6,
                              color: AppColors.ink,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Jelajahi data dari REST API',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 4),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                      splashBorderRadius: BorderRadius.circular(999),
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.muted,
                      labelStyle: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: [
                        for (final t in _tabs)
                          Tab(
                            height: 38,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(t.$1, size: 17),
                                  const SizedBox(width: 6),
                                  Text(t.$2),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppColors.border),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  PostTab(),
                  PhotosTab(),
                  CommentTab(),
                  AlbumsTab(),
                  TodosTab(),
                  UsersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}