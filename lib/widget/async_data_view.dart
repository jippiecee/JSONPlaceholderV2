import 'package:flutter/material.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';
import 'package:jsonplaceholder/widget/app_card.dart';

// <T> dipakai untuk mendefinisikan tipe data yang akan ditampilkan
class AsyncDataView<T> extends StatefulWidget {
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String title;

  /// Isi > 1 untuk tampilan grid (contoh: Photos).
  final int gridColumns;
  final double gridItemExtent;

  const AsyncDataView({
    super.key,
    required this.onFetch,
    required this.itemBuilder,
    required this.title,
    this.gridColumns = 1,
    this.gridItemExtent = 200,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  late Future<List<T>> _future;

  bool get _isGrid => widget.gridColumns > 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = widget.onFetch();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadData();
    });
    await _future.catchError((_) => <T>[]);
  }

  SliverGridDelegate get _gridDelegate => SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.gridColumns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: widget.gridItemExtent,
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _Skeleton(
            columns: widget.gridColumns,
            extent: widget.gridItemExtent,
          );
        }

        // 2. Error
        if (snapshot.hasError) {
          return _StateMessage(
            icon: Icons.cloud_off_outlined,
            color: const Color(0xFFE5484D),
            title: 'Gagal memuat ${widget.title}',
            subtitle: '${snapshot.error}',
            action: FilledButton.icon(
              onPressed: _handleRefresh,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Coba lagi'),
            ),
          );
        }

        // 3. Empty
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return _StateMessage(
            icon: Icons.inbox_outlined,
            color: AppColors.subtle,
            title: 'Belum ada data',
            subtitle: '${widget.title} masih kosong.',
          );
        }

        // 4. Success + pull to refresh
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Pill('${items.length}'),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_downward_rounded,
                    size: 13,
                    color: AppColors.subtle,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Tarik untuk refresh',
                    style: TextStyle(fontSize: 12, color: AppColors.subtle),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: _handleRefresh,
                child: _isGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        gridDelegate: _gridDelegate,
                        itemCount: items.length,
                        itemBuilder: (context, index) => _FadeSlideIn(
                          index: index,
                          child: widget.itemBuilder(context, items[index], index),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 4, bottom: 24),
                        itemCount: items.length,
                        itemBuilder: (context, index) => _FadeSlideIn(
                          index: index,
                          child: widget.itemBuilder(context, items[index], index),
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Animasi muncul untuk 10 item pertama.
class _FadeSlideIn extends StatelessWidget {
  final int index;
  final Widget child;
  const _FadeSlideIn({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    if (index > 9) return child;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 320 + index * 50),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, (1 - v) * 14),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// Tampilan untuk state error / kosong.
class _StateMessage extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final Widget? action;

  const _StateMessage({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13.5, color: AppColors.muted),
            ),
            if (action != null) ...[const SizedBox(height: 20), action!],
          ],
        ),
      ),
    );
  }
}

/// Loading skeleton yang berdenyut.
class _Skeleton extends StatefulWidget {
  final int columns;
  final double extent;
  const _Skeleton({required this.columns, required this.extent});

  @override
  State<_Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<_Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _bar(double factor, {double height = 12}) {
    return FractionallySizedBox(
      widthFactor: factor,
      alignment: Alignment.centerLeft,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.skeleton,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isGrid = widget.columns > 1;

    return FadeTransition(
      opacity: Tween(begin: 0.45, end: 1.0).animate(
        CurvedAnimation(parent: _c, curve: Curves.easeInOut),
      ),
      child: isGrid
          ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.columns,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: widget.extent,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: AppColors.skeleton,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              itemCount: 7,
              itemBuilder: (context, index) => AppCard(
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.skeleton,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        children: [
                          _bar(0.55, height: 14),
                          const SizedBox(height: 10),
                          _bar(1),
                          const SizedBox(height: 6),
                          _bar(0.8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}