import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}


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
      home: MyHomePage(title: 'Flutter Riverpod Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  static const kKey = 'keyCounter';

  final _futureProvider = FutureProvider((ref) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(kKey) ?? 0;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              'ボタンを押すと1増えます。',
            ),
            ref.watch(_futureProvider).when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => const Text('error'),
              data: (data) => Text(
                '${ref.watch(_futureProvider).value}',
                //style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          int currentValue = prefs.getInt(kKey) ?? 0;
          prefs.setInt(kKey, currentValue + 1);
          ref.invalidate(_futureProvider);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}