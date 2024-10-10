import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class Message extends StatefulWidget {
  const Message({super.key, required this.task, required this.description});
  final String task, description;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  bool _locked = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Icon(LucideIcons.chevron_up,
                    color: Colors.grey, size: 30),
                Text(
                  widget.task,
                  style: const TextStyle(fontSize: 35),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                // Text(
                // DateFormat.yMMMd().add_jm().format(
                // DateTime.parse('56877'
                // widget.data['createdOn'].toDate().toString(),
                // ),
                // ),
                // ),
                const SizedBox(height: 15),
                SelectableText(
                  widget.description,
                  style: const TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton.icon(
                      label: Text(_locked ? 'Lock' : 'Unlock'),
                      icon: Icon(
                          _locked ? LucideIcons.lock : LucideIcons.lock_open),
                      onPressed: () => setState(() => _locked = !_locked),
                      // color: Colors.green,
                      // color: Color(int.parse(widget.data['color'])).withOpacity(1),
                    ),
                    ElevatedButton.icon(
                      label: Text('Close'),
                      icon: Icon(LucideIcons.x),
                      onPressed: () => Navigator.pop(context),
                    ),
                    if (!_locked)
                      ElevatedButton.icon(
                        label: Text('Delete'),
                        icon: Icon(LucideIcons.trash_2),
                        onPressed: () => Navigator.pop(context),
                      ),
                    if (!_locked)
                      ElevatedButton.icon(
                        label: Text('Edit'),
                        icon: Icon(LucideIcons.pencil),
                        onPressed: () => {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return UpdateFoldersScreen(
                          //         id: widget.data.id,
                          //         task: widget.data['task'],
                          //         desc: widget.data['description'],
                          //         category: widget.data['category'],
                          //         completed: widget.data['completed'],
                          //       );
                          //     },
                          //   ),
                          // )
                        },
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
