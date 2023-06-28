import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_study/dogImage.dart'; // 追加

final counterProvider = StateNotifierProvider((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);
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

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => DogImageWidget(),
//       },
//     );
//   }
// }

// class CounterWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final counter = ref.watch(counterProvider);

//     void _incrementCounter() {
//       ref.read(counterProvider.notifier).state++;
//     }

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           'Counter',
//           style: TextStyle(fontSize: 24),
//         ),
//         Text(
//           '$counter',
//           style: const TextStyle(fontSize: 48),
//         ),
//         ElevatedButton(
//           onPressed: _incrementCounter,
//           child: const Text('Increment'),
//         ),
//       ],
//     );
//   }
// }
