import 'package:aloha/auth/signin.dart';
import 'package:aloha/constant.dart';
import 'package:aloha/tasks/details.dart';
import 'package:aloha/tasks/message.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.text});
  final String text;
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final future = supabase
        .from('tasks')
        .select('task,description')
        .eq('category', widget.text.toLowerCase())
        .order('id');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          SliverAppBar.large(
            title: Text(widget.text.toUpperCase()),
            centerTitle: true,
            elevation: 10,
          ),

          //body
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(child: CircularProgressIndicator()),
                ));
              }
              final tasks = snapshot.data!;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      child: ListTile(
                        title: Text(
                          task['task'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            // decoration:
                            // task['completed'] ? TextDecoration.lineThrough : null,
                            // decorationThickness: 3,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        tileColor: giveCategoryGetColor(widget.text),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        onTap: () => showModalBottomSheet(
                          clipBehavior: Clip.hardEdge,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Message(
                            task: task['task'] ?? '',
                            description: task['description'] ?? '',
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                        ),
                        onLongPress: () {},
                      ),
                    );
                  },
                  childCount: tasks.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
