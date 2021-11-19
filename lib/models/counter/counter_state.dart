import 'package:boilerplatev1/models/counter/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier({Counter counter = const Counter(count: 0)}) : super(counter);

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}
