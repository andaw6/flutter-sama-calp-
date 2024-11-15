double convertToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.tryParse(value) ??
        0.0; // retourne 0.0 si la conversion échoue
  } else {
    throw ArgumentError(
        "La valeur fournie n'est pas un nombre valide : $value");
  }
}
