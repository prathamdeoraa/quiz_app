import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers.dart';

class ResultView extends ConsumerWidget {
  final int score;
  final int total;
  final String tag; // 👈 add this

  const ResultView({
    required this.score,
    required this.total,
    required this.tag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(quizViewModelProvider(tag).notifier); // ✅ use tag

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 64),
          const SizedBox(height: 16),
          Text(
            'Quiz Completed!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            'Your Score: $score / $total',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: vm.restartSameQuiz,
            icon: const Icon(Icons.replay_circle_filled_outlined),
            label: const Text('Restart Same Quiz'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: vm.restartNewQuiz,
            icon: const Icon(Icons.refresh),
            label: const Text('Try New Questions'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              // Invalidate provider to reset old quiz state
              ref.invalidate(quizViewModelProvider(tag));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Choose Another Category'),
          ),
        ],
      ),
    );
  }
}
