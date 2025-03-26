import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'page_a.dart';
import 'page_b.dart';
import 'page_c.dart';

main() {
  // アプリ
  const app = MaterialApp(home: RootSnow());

  // プロバイダースコープでアプリを囲む
  const scope = ProviderScope(child: app);
  runApp(scope);
}

// リバーポッドのプロバイダーで監視
//　indexProvider : 0の様に設定
final indexProvider = StateProvider((ref) {
  return 0;
},);

class RootSnow extends ConsumerWidget {
  const RootSnow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // インデックスの監視
    final index = ref.watch(indexProvider);

    // アイテムたち
    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.downhill_skiing),
        label: 'スキー',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.snowboarding),
        label: 'スノーボード',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.ac_unit),
        label: 'スノー',
      ),
    ];

    // 下のバー
    final bar = BottomNavigationBar(
      items: items, // アイテムたち
      backgroundColor: Colors.grey, // バーの色
      selectedItemColor: Colors.white, // 選ばれたアイテムの色
      unselectedItemColor: Colors.black, // 選ばれていないアイテムの色
      currentIndex: index, // インデックス
      onTap: (index) {
        // タップされたとき インデックスを変更する
        ref.read(indexProvider.notifier).state = index;
      },
    );

    // 画面たち
    const pages = [
      PageA(),
      PageB(),
      PageC(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: bar,
    );
  }
}