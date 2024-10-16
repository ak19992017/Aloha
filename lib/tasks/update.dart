import 'package:aloha/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class UpdateFoldersScreen extends StatefulWidget {
  const UpdateFoldersScreen({
    super.key,
    required this.task,
    required this.desc,
    required this.category,
    // required this.completed,
    // required this.id,
  });
  // final String id;
  final String task;
  final String desc;
  final String category;
  // final bool completed;

  @override
  State<UpdateFoldersScreen> createState() => _UpdateFoldersScreenState();
}

class _UpdateFoldersScreenState extends State<UpdateFoldersScreen> {
  late TextEditingController _task;
  late TextEditingController _desc;
  late String _dropdownValue;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _task = TextEditingController(text: widget.task);
    _desc = TextEditingController(text: widget.desc);
    _dropdownValue = widget.category;
    _completed = true;
  }

  @override
  Widget build(BuildContext context) {
    // FirestoreServices firestoreServices = FirestoreServices();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Task'),
          // backgroundColor: giveCategoryGetColor(_dropdownValue),
          elevation: 0,
          centerTitle: true,
          leading: IconButton.filledTonal(
            icon: Icon(LucideIcons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      const Text('Task',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter task here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        controller: _task,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Enter description here',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                        controller: _desc,
                        maxLines: 6,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  DropdownButton<String>(
                    value: _dropdownValue,
                    items: folderList
                        .map<DropdownMenuItem<String>>((String value) =>
                            DropdownMenuItem<String>(
                                value: value, child: Text(value)))
                        .toList(),
                    onChanged: (String? newValue) =>
                        setState(() => _dropdownValue = newValue!),
                  ),
                  Switch(
                    value: _completed,
                    onChanged: (value) => setState(() => _completed = value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: ButtonStyle(
                          // backgroundColor: WidgetStateProperty.all(
                          //     giveCategoryGetColor(_dropdownValue)),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 5))),
                      onPressed: () {
                        // firestoreServices.updateTask(_task.text, _desc.text,
                        // _completed, _dropdownValue, widget.id);

                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'UPDATE TASK',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
