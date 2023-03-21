import 'package:flutter/material.dart';

Widget buildSheet() {
  return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(),
        );
      });
}
