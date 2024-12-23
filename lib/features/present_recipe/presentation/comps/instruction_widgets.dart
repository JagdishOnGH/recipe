import 'package:flutter/material.dart';

class InstructionDisplay extends StatelessWidget {
  final bool isInstruction;

  final List<String> instructions;

  const InstructionDisplay({
    this.isInstruction = false,
    Key? key,
    required this.instructions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stepOrItem = isInstruction ? 'Step' : 'Item';

    final theme = Theme.of(context);

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: instructions.length,
      itemBuilder: (context, index) {
        final instruction = instructions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
              children: [
                TextSpan(
                  text: '$stepOrItem ${index + 1}: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: instruction,
                  style: const TextStyle(
//color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
