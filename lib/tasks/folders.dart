import 'package:aloha/tasks/tasks.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  DateTime timeBackPressed = DateTime.now();
  Color selectedColor = Colors.grey;
  List folderList = [
    {'title': 'home', 'color': Colors.redAccent, 'img': 'assets/pencil.png'},
    {
      'title': 'work',
      'color': Colors.greenAccent.shade700,
      'img': 'assets/travel.png'
    },
    {
      'title': 'code',
      'color': Colors.blueAccent,
      'img': 'assets/takeaway-cup.png'
    },
    {'title': 'play', 'color': Colors.orange, 'img': 'assets/rocket.png'},
  ];
  // text field
  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String title) {
    setState(() => folderList.add(
        {'title': title, 'color': selectedColor, 'img': 'assets/pencil.png'}));
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                            TasksScreen(text: folderList[index]['title']),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: folderList[index]['color'],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(folderList[index]['img']),
                          FittedBox(
                            child: Text(
                              folderList[index]['title'].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: folderList.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  icon: Icon(LucideIcons.plus, color: Colors.white),
                  onPressed: () => _displayDialog(context),
                  label: Text(
                    'Add category',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // display a dialog for the user to enter items
  Future _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Add category'),
              elevation: 0,
              centerTitle: true,
              leading: IconButton.filledTonal(
                icon: Icon(LucideIcons.chevron_left),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter task here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      controller: _textFieldController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  ColorPicker(
                    color: selectedColor,
                    onColorChanged: (Color newColor) =>
                        setState(() => selectedColor = newColor),
                    borderRadius: 20,
                    subheading: const Text('Select a color for your widget'),
                  ),
                  // Cancel button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _textFieldController.clear();
                        },
                      ),
                      // add button
                      FilledButton(
                        child: const Text('ADD'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _addTodoItem(_textFieldController.text.toString());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
