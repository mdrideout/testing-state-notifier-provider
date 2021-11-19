import 'package:boilerplatev1/models/counter/counter.dart';
import 'package:boilerplatev1/models/counter/counter_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, Counter>((ref) => CounterNotifier());
