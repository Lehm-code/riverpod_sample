import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// カウンターの状態プロバイダ
final counterProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

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
      home: const MyHomePage(title: 'Flutter Riverpod Demo Home Page'),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ボタンを押すと2倍します。',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final before = ref.read(counterProvider);
          debugPrint('---------------');
          debugPrint('更新前は $before');
          //ref.read(counterProvider.notifier).countUp();
          ref.read(counterProvider.notifier).countDouble();
          final after = ref.read(counterProvider);
          debugPrint('更新後は $after');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(5);
  void countUp() {
    state++;
  }

  void countDouble() {
    state = state * 2;
  }

  void countReset() {
    state = 0;
  }
}
