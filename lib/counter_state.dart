import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'counter_state.freezed.dart';
part 'counter_state.g.dart';

@freezed
abstract class CounterState with _$CounterState {
  const factory CounterState({

    // デフォルト値
    @Default(0) int count,

  }) = _CounterState;
  // このメソッドはこのカウンターアプリでは使用しないが、JsonからStateを生成する場合によく使うため記述している
  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);
}

// CounterStateNotifierは、状態を操作するロジックを管理し、Widgetに状態の変化を通知する
// MVVMでいうとVMに相当する 
class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(const CounterState()) {}
  
  // copyWithメソッドは、状態を更新する場合に、新しく状態を生成する（clone）するために使う
  // CouterStateのcountを1カウントアップした状態をcopyWithメソッドを使用し、新しく状態を作成して更新している
  increment() => state = state.copyWith(count: state.count + 1);
}