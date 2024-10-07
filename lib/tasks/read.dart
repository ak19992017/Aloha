import 'package:aloha/auth/signin.dart';
import 'package:aloha/constant.dart';
import 'package:flutter/material.dart';

class ReadTaskScreen extends StatefulWidget {
  const ReadTaskScreen({super.key, required this.text});
  final String text;
  @override
  State<ReadTaskScreen> createState() => _ReadTaskScreenState();
}

class _ReadTaskScreenState extends State<ReadTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final future = supabase
        .from('tasks')
        .select('task')
        .eq('category', widget.text.toLowerCase());

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.text.toUpperCase()),
          centerTitle: true,
          elevation: 10),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: ((context, index) {
              final task = tasks[index];
              return Padding(
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                child: ListTile(
                  title: Text(
                    task['task'],
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  onTap: () {
                    showModalBottomSheet(
                      clipBehavior: Clip.hardEdge,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.5,
                          minChildSize: 0.2,
                          maxChildSize: 1,
                          expand: false,
                          builder: (_, controller) => SingleChildScrollView(
                            controller: controller,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              // child: Message(document: document),
                            ),
                          ),
                        );
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                    );
                  },
                  onLongPress: () {},
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
