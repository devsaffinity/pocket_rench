import 'package:flutter/widgets.dart';

extension ContextInsets on BuildContext {
  double get topInset => MediaQuery.paddingOf(this).top;
  double get bottomInset => MediaQuery.paddingOf(this).bottom;
}

extension StringX on String {
  bool get isBlank => trim().isEmpty;
}
