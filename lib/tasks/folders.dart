import 'package:aloha/constant.dart';
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
      'img': 'travel/image1.png'
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
    setState(() => folderList.add(title));
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
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
                          // Image.asset('assets/${imageList[index]}'),
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
              child: Card.filled(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.plus, color: Colors.white),
                        TextButton(
                          onPressed: () => _displayDialog(context),
                          child: Text(
                            'Add category',
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Text(
                  'Calender',
                  style: Theme.of(context).textTheme.displayMedium,
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
          child: Column(
            children: [
              Text('Add category',
                  style: Theme.of(context).textTheme.headlineLarge),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: 'Enter task here'),
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
                      _addTodoItem(_textFieldController.text);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
