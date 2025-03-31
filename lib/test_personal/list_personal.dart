import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope( // Riverpodの状態管理スコープ
      child: MyApp(),
    ),
  );
}

// 名前用のStateProvider
final listProvider = StateProvider<List<String>>((ref) {
  return ['testA', 'testB', 'testC'];
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // nameProviderの現在の値を取得
    final lists = ref.watch(listProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List Riverpod'),
        ),
        body: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(lists[index]),
            );
          },
        ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(listProvider.notifier).update((state) => [...state, 'add item']);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}

