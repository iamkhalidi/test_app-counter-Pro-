import 'dart:ui';

import 'package:get/get.dart';
import '../model/counter_model.dart';

class HomeController extends GetxController {
  final _model = CounterModel().obs;

  int get value => _model.value.value;
  bool get canIncrement => _model.value.canIncrement;
  bool get canDecrement => _model.value.canDecrement;

  void increment() {
    if (_model.value.canIncrement) {
      _model.update((val) {
        val!.value += val.step;
      });
    }
  }

  void decrement() {
    if (_model.value.canDecrement) {
      _model.update((val) {
        val!.value -= val.step;
      });
    }
  }

  void reset() {
    _model.update((val) {
      val!.value = 0;
    });
  }

  String get valueLabel {
    if (value > 0) return '+$value';
    return '$value';
  }

  Color get valueColor {
    if (value > 0) return const Color(0xFF00C48C);
    if (value < 0) return const Color(0xFFFF5C5C);
    return const Color(0xFF6C63FF);
  }
}