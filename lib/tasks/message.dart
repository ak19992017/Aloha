import 'package:aloha/tasks/button.dart';
import 'package:aloha/tasks/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:intl/intl.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.document});
  final String document;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool _locked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(LucideIcons.chevron_up, color: Colors.grey, size: 30),
        Text(
          'mmmmm',
          // widget.document['task'],
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        Text(
          DateFormat.yMMMd().add_jm().format(
                DateTime.parse('56877'
                    // widget.document['createdOn'].toDate().toString(),
                    ),
              ),
        ),
        const SizedBox(height: 15),
        SelectableText(
          'ftress',
          // widget.document['description'],
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 40),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            SuperButton(
              label: _locked ? 'Unlock' : 'Lock',
              icon: _locked ? LucideIcons.lock_open : LucideIcons.lock,
              onPress: () {
                setState(() {
                  _locked = !_locked;
                });
              },
              color: Colors.green,
              // color: Color(int.parse(widget.document['color'])).withOpacity(1),
            ),
            SuperButton(
              label: 'Close',
              icon: LucideIcons.x,
              onPress: () => Navigator.pop(context), color: Colors.green,
              // color: Color(int.parse(widget.document['color'])).withOpacity(1),
            ),
            // if (!_locked)
            //   SuperButton(
            //     label: 'Delete',
            //     icon: LucideIcons.trash_2,
            //     onPress: () {
            //       // firestoreServices.deleteTask(widget.document.id);
            //       Navigator.pop(context);
            //     },
            //     color:
            //         // Color(int.parse(widget.document['color'])).withOpacity(1),
            //   ),
            // if (!_locked)
            // SuperButton(
            // label: 'Edit',
            // icon: LucideIcons.pencil,
            // onPress: () => Navigator.push(
            // context,
            // MaterialPageRoute(
            // builder: (context) {
            // return UpdateTaskScreen(
            //   id: widget.document.id,
            //   task: widget.document['task'],
            //   desc: widget.document['description'],
            //   category: widget.document['category'],
            //   completed: widget.document['completed'],
            // );
            // },
            // ),
            // ),
            // color:
            // Color(int.parse(widget.document['color'])).withOpacity(1),
            // ),
          ],
        )
      ],
    );
  }
}
