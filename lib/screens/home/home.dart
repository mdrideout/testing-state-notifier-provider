import 'package:boilerplatev1/models/counter/counter.dart';
import 'package:boilerplatev1/models/counter/counter_providers.dart';
import 'package:boilerplatev1/screens/home/is_even.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Counter counter = ref.watch(counterProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Count: '),
                Text(counter.count.toStringAsFixed(0)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).increment();
                  },
                  child: const Text("Increment"),
                )
              ],
            ),
            const SizedBox(height: 5),
            (counter.count.isEven)
                ? const IsEvenMessage() // TODO: Test that when count is even, we show this widget.
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
