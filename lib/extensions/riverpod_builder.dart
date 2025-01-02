import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodBuilder extends ConsumerWidget {
  final Function(BuildContext context, WidgetRef ref) builder;

  const RiverpodBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, ref);
  }
}
