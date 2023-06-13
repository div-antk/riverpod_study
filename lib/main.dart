import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/dogImage.dart'; // 追加

final counterProvider = StateProvider<int>((ref) => 0); // 追加

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Sample',
      home: DogImageWidget(),
    ),
  ));
}

// void main() {
//   runApp(ProviderScope(
//     child: MaterialApp(
//       title: 'Sample',
//       home: CounterWidget(),
//     ),
//   ));
// }

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    void _incrementCounter() {
      ref.read(counterProvider.notifier).state++;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Counter',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '$counter',
          style: const TextStyle(fontSize: 48),
        ),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}


// class CounterWidget extends StatefulWidget {
//   @override
//   _CounterWidgetState createState() => _CounterWidgetState();
// }

// class _CounterWidgetState extends State<CounterWidget> {
//   // 変数が『状態』を表す
//   int _counter = 0;

//   // このメソッドで状態が更新され、setStateが呼び出されてWidgetの再構築がトリガーされる
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           'Counter',
//           style: TextStyle(fontSize: 24),
//         ),
//         Text(
//           '$_counter',
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




