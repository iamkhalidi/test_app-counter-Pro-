class CounterModel {
  int value;
  final int step;
  final int min;
  final int max;

  CounterModel({
    this.value = 0,
    this.step = 1,
    this.min = -999,
    this.max = 999,
  });

  bool get canIncrement => value < max;
  bool get canDecrement => value > min;
}