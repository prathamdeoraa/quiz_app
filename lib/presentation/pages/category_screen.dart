import 'package:flutter/material.dart';
import 'package:quiz_app/presentation/pages/quiz_home_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  List categoryList = [
    'PHP',
    'NodeJs',
    'Next.js',
    'html',
    'wordpress',
    'MySQL',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App'), centerTitle: true),

      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(),
              child: Text(
                '${'Select Quiz Category'.toUpperCase()}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 200,
                ),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final tag = categoryList[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizHomeScreen(tag: 'php'),
                      ),
                    ),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      shadowColor: Colors.pink.shade400,
                      child: Center(
                        child: Text(tag.toString().toUpperCase()),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
