import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
    {String? title,
    Color? backgroundColor = Colors.transparent,
    Color? surfaceTintColor = Colors.white,
    Widget? flexibleSpace,
    Widget? leading}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title ?? '',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    leading: leading,
    surfaceTintColor: surfaceTintColor,
    backgroundColor: backgroundColor,
    flexibleSpace: flexibleSpace,
  );
}
