class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.measure, required this.name});

  String getMeasure() {
    return measure;
  }

  String getName() {
    return name;
  }
}
