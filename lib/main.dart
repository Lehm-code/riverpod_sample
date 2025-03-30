import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // 状態管理する範囲を指定
    const ProviderScope(
      child: MyApp()
    )
  );
}

// カウンターの状態プロバイダを生成と初期値の代入
final counterProvider = StateProvider<int>((ref) => 0);
final doubleProvider = StateProvider<int>((ref) => 0);
final doubleProvider2 = StateProvider<int>((ref) => 0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Riverpodデモ'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダから状態を取得
    final counter = ref.watch(counterProvider);
    final doubleCounter = ref.watch(doubleProvider);
    final doubleCounter2 = ref.watch(doubleProvider2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ボタンを押すと増えるよ'),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('上の数字の2倍だよ'),
            Text(
              '$doubleCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$doubleCounter2',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
          // 1つ前の数字を使ってしまう場合
          ref.read(doubleProvider.notifier).state = counter * 2;
          //ref.read(doubleProvider.notifier).state = counterProvider.state * 2;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

