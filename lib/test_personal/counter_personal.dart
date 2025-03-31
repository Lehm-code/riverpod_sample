import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // 状態管理する範囲を指定
    ProviderScope(
      overrides: [
        overrideProvider.overrideWith((ref) {
          return 30;
        }),
      ],
      child: const MyApp()
    )
  );
}

// カウンターの状態プロバイダを生成と初期値の代入
final counterProvider = StateProvider<int>((ref){
  return 0 ;
});
final doubleProvider = StateProvider<int>((ref) => 0);
final doubleProvider2 = Provider<int>((ref){
  final count = ref.watch(counterProvider);
  return count * 2 ;
});
final overrideProvider = StateProvider<int>((ref) => 0);

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
    final doubleCounter3 = counter *2;
    final overrideCounter = ref.watch(overrideProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ボタンを押すと 1 増えるよ'),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('上の数字の遅れた2倍だよ'),
            Text(
              '$doubleCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('最上部の数字の2倍だよ（Provider内の定義）'),
            Text(
              '$doubleCounter2',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('最上部の数字の2倍だよ（class内の定義）'),
            Text(
              '$doubleCounter3',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('オーバーライドのテスト'),
            Text(
              '$overrideCounter',
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
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

