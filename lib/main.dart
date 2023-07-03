import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// StateNotifierProviderを使用する
final counterProvider = StateNotifierProvider((_) => Counter());

// StateNotifierを継承したクラスを作成
// <T> （Type）の 部分にstateの肩を入れる。これが監視対象
class Counter extends StateNotifier<int> {
  // Counterのstateに0を代入
  Counter() : super(0);
  // increment()を呼ぶことでstateの値を+1する
  void increment() => state++;
}

void main() {
  runApp(
    // RiverPodを使うためにCounterAppをProviderScopeでラップする
    const ProviderScope(child: CounterApp()),
  );
}

// Flutter Hooksを使いたいクラスに HookConsumerWidget を継承
// HookConsumerWidget を継承している場合、build関数の第二引数は WidgetRef になるので注意 
class CounterApp extends HookConsumerWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // HookConsumerWidgetを継承しているClass内のbuild関数内で定義することで、CounterクラスのstateをWidgetツリーの中で使うことができる
    final state = ref.watch(counterProvider);
    
    // useStateを使って値を変化させたいものを定義する
    final isWhiteBackGround = useState(true);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: isWhiteBackGround.value ? Colors.white : Colors.black,
        appBar: AppBar(
          title: const Text('カウンターアップ'),
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => isWhiteBackGround.value = !isWhiteBackGround.value,
          ),
        ),
        body: Center(
          child: Text(
            state.toString(),
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: isWhiteBackGround.value ? Colors.black : Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}