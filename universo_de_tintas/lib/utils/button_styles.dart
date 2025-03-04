import 'package:flutter/material.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
);
