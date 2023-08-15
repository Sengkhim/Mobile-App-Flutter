extension ListExtension<T> on List<T> {
  double sumBy(double Function(T element) f) {
    double sum = 0;
    for (var item in this) {
      sum += f(item);
    }
    return sum;
  }
}
