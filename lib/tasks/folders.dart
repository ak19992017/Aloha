import 'package:aloha/constant.dart';
import 'package:aloha/tasks/tasks.dart';
import 'package:flutter/material.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TasksScreen(text: folderList[index]),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: giveCategoryGetColor(folderList[index]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/${imageList[index]}'),
                          Text(
                            folderList[index].toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: Colors.white),
                            // const TextStyle(
                            // fontSize: 35,
                            // color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            // ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: folderList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
