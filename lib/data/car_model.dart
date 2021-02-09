import 'package:flutter/foundation.dart';

class Car {
  final String name;
  final String model;
  final double amount;
  final List<String> urls;
  const Car({
    @required this.name,
    @required this.model,
    @required this.amount,
    @required this.urls,
  });
}
