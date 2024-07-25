import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({required String title}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
