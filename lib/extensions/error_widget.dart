import 'package:flutter/material.dart';
import 'package:recipe_app/extensions/on_num.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String message;

  const CustomErrorWidget(
      {Key? key, required this.message, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(message),
        ),
        20.ht,
        SizedBox(
          width: 200,
          child: OutlinedButton(
            onPressed: onRetry,
            child: Text("Retry"),
          ),
        )
      ],
    );
  }
}
