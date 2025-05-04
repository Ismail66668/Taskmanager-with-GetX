// ignore: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class SummaryCountCard extends StatelessWidget {
  SummaryCountCard({super.key, required this.name, required this.count});
  String name;
  int count;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      height: 85,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$count",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
