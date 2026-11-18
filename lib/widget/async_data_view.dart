import 'package:flutter/material.dart';

// Kegunakan <T> adalah untuk mendefinisikan tipe data yang akan digunakan
class AsyncDataView<T> extends StatefulWidget {
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
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
  // Variabel untuk menyimpan data yang akan ditampilkan
  late Future<List<T>> _future;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data dari API
  void _loadData() {
    _future = widget.onFetch();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Memuat ${widget.title}'),
              ],
            ),
          );
        }

        // 2. Error State
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 12),
                Text('${snapshot.error}'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _handleRefresh,
                  child: const Text('Refresh Page'),
                ),
              ],
            ),
          );
        }

        // 3. Empty State
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return Center(child: Text('Data is empty ${widget.title}'));
        }

        //4. Succes state with Pull to Refresh

        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ${items.length} ${widget.title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Tarik ke bawah untuk Refresh'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return widget.itemBuilder(context, items[index], index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}