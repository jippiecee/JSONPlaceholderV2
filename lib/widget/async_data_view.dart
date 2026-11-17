import 'package:flutter/material.dart';

/// Widget generik yang menangani 4 kondisi async:
/// loading, error, empty, dan success (dengan pull-to-refresh).
/// <T> = tipe model yang dipakai (Post, Comments, dst).
class AsyncDataView<T> extends StatefulWidget {
  /// Fungsi untuk mengambil data dari API.
  final Future<List<T>> Function() onFetch;

  /// Cara menampilkan SATU item.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Nama data, dipakai di teks loading dan kosong.
  final String title;

  const AsyncDataView({
    super.key,
    required this.onFetch,
    required this.itemBuilder,
    required this.title,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  /// Menyimpan "tiket" Future supaya tidak request ulang tiap rebuild.
  late Future<List<T>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _future = widget.onFetch();
  }

  Future<void> _handleRefresh() async {
    setState(_loadData);
    try {
      await _future;
    } catch (_) {
      // Error ditampilkan oleh FutureBuilder, jadi di sini diabaikan.
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Memuat ${widget.title}...'),
              ],
            ),
          );
        }

        // 2. Error
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, size: 48),
                const SizedBox(height: 12),
                Text('${snapshot.error}'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _handleRefresh,
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          );
        }

        // 3. Empty
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(child: Text('${widget.title} kosong'));
        }

        // 4. Success + pull-to-refresh
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) =>
                widget.itemBuilder(context, items[index], index),
          ),
        );
      },
    );
  }
}