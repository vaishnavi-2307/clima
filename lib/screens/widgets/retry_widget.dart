import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No internet connection available.',
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
