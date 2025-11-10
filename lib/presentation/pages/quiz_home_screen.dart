import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/presentation/pages/result_page.dart';
import 'package:quiz_app/presentation/viewmodels/quiz_state.dart';
import 'package:quiz_app/providers.dart';

class QuizHomeScreen extends ConsumerWidget {
  final String tag;

  const QuizHomeScreen({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizViewModelProvider(tag));
    final vm = ref.read(quizViewModelProvider(tag).notifier);

    // Load quiz only once when in initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.maybeWhen(initial: () => vm.loadQuiz(tag), orElse: () {});
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state.when(
          initial: () => const Center(child: Text('Loading Quiz .......')),

          loading: () => const Center(child: CircularProgressIndicator()),

          error: (msg) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $msg'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => vm.loadQuiz(tag),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),

          // ✅ Loaded state
          loaded: (questions, score, currentIndex) {
            if (currentIndex >= questions.length) {
              // ✅ Show result view
              return ResultView(
                score: score,
                total: questions.length,
                tag: tag,
              );
            }

            final q = questions[currentIndex];
            final selected = vm.selectedIndex; // ✅ current selected option

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q.${currentIndex + 1} ',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: Text(
                            q.question,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ✅ Radio options
                Expanded(
                  child: ListView.separated(
                    itemCount: q.options.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        child: RadioListTile<int>(
                          activeColor: Colors.indigo,
                          title: Text(q.options[index]),
                          value: index,
                          groupValue: selected,
                          onChanged: (value) {
                            print(value);
                            vm.selectOption(value!);
                          },
                        ),
                      );
                    },
                  ),
                ),

                // ✅ Next button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: selected != null ? vm.submitAns : null,
                    icon: Icon(
                      currentIndex == questions.length - 1
                          ? Icons.done
                          : Icons.navigate_next,
                    ),
                    label: Text(
                      currentIndex == questions.length - 1 ? 'Finish' : 'Next',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
