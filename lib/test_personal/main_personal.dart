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
final nameProvider = StateProvider<String>((ref) => 'Riverpod初心者');

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // nameProviderの現在の値を取得
    final name = ref.watch(nameProvider);

    return MaterialApp(
      title: 'Riverpod練習',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('個人練習用')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 状態を変更する例
                  ref.read(nameProvider.notifier).state = '状態が更新されました';
                },
                child: const Text('名前を変更'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
