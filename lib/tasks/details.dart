import 'package:aloha/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_quill/flutter_quill.dart';

const menuConfig = [
  {'title': "Lock", 'icon': LucideIcons.lock},
  {'title': "Add to favourite", 'icon': LucideIcons.heart},
  {'title': "Share", 'icon': LucideIcons.share_2},
  {'title': "Delete", 'icon': LucideIcons.trash},
];

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.task,
      required this.description,
      required this.category});
  final String task, description, category;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
    _controller.readOnly = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: giveCategoryGetColor(widget.category),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              widget.task,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          centerTitle: true,
          elevation: 10,
          stretch: true,
          expandedHeight: 250,
          pinned: true,
          floating: true,
          snap: true,
          actions: [
            IconButton.filledTonal(
                color: canEdit ? Colors.purple[200] : Colors.deepPurple,
                icon: Icon(LucideIcons.pencil),
                onPressed: () {
                  setState(() {
                    canEdit = !canEdit;
                    _controller.readOnly = !canEdit;
                    // print(canEdit);
                  });
                }),
            IconButton.filledTonal(
              icon: Icon(LucideIcons.ellipsis_vertical),
              onPressed: () {
                showModalBottomSheet(
                  clipBehavior: Clip.hardEdge,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: ListTile(
                          leading: Icon(menuConfig[index]["icon"] as IconData?),
                          title: Text(menuConfig[index]["title"].toString()),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: menuConfig.length,
                  ),
                  // Message(
                  //   task: task['task'] ?? '',
                  //   description: task['description'] ?? '',
                  // ),
                  // shape: const RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(50),
                  //     topRight: Radius.circular(50),
                  //   ),
                  // ),
                );
              },
            ),
          ],
          leading: IconButton.filledTonal(
            icon: Icon(LucideIcons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        // SliverToBoxAdapter(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        //     child: Wrap(
        //       spacing: 4,
        //       children: [
        //         IconButton.filledTonal(
        //             icon: Icon(LucideIcons.link), onPressed: () {}),
        //         IconButton.filledTonal(
        //             icon: Icon(LucideIcons.image), onPressed: () {}),
        //         IconButton.filledTonal(
        //             icon: Icon(LucideIcons.file), onPressed: () {}),
        //         IconButton.filledTonal(
        //             icon: Icon(LucideIcons.mic), onPressed: () {}),
        //       ],
        //     ),
        //   ),
        // ),
        if (canEdit)
          SliverToBoxAdapter(
            child: QuillSimpleToolbar(
              controller: _controller,
              configurations: const QuillSimpleToolbarConfigurations(
                toolbarIconAlignment: WrapAlignment.start,
                buttonOptions: QuillSimpleToolbarButtonOptions(
                    bold: QuillToolbarToggleStyleButtonOptions(
                        iconData: LucideIcons.bold),
                    italic: QuillToolbarToggleStyleButtonOptions(
                        iconData: LucideIcons.italic),
                    underLine: QuillToolbarToggleStyleButtonOptions(
                        iconData: LucideIcons.underline),
                    listBullets: QuillToolbarToggleStyleButtonOptions(
                        iconData: LucideIcons.list),
                    toggleCheckList: QuillToolbarToggleCheckListButtonOptions(
                        iconData: LucideIcons.square_check)),
                showUndo: false,
                showRedo: false,
                showFontFamily: false,
                showFontSize: false,
                showSubscript: false,
                showSuperscript: false,
                showCodeBlock: false,
                showInlineCode: false,
                showJustifyAlignment: false,
                showClipboardCopy: false,
                showClipboardCut: false,
                showClipboardPaste: false,
                showSearchButton: false,
                showBackgroundColorButton: false,
                showLink: false,
                showQuote: false,
                showIndent: false,
                showDividers: false,
                showColorButton: false,
                showStrikeThrough: false,
                showClearFormat: false,
                // multiRowsDisplay: false,
              ),
            ),
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: giveCategoryGetColor(widget.category).withOpacity(0.4),
              ),
              child: QuillEditor.basic(
                controller: _controller,
                configurations: QuillEditorConfigurations(
                  padding: const EdgeInsets.all(10),
                  showCursor: canEdit,
                  autoFocus: !canEdit,
                ),
              ),
            ),
          ),
        )
        // SliverList.builder(
        //     itemCount: 20,
        //     itemBuilder: (_, index) {
        //       return Padding(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        //         child: ListTile(
        //           title: Text(
        //             'Hello',
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 1,
        //             style: Theme.of(context)
        //                 .textTheme
        //                 .headlineMedium
        //                 ?.copyWith(color: Colors.white),
        //           ),
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(20)),
        //           tileColor: giveCategoryGetColor('code'),
        //           contentPadding:
        //               const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        //         ),
        //       );
        //     })
      ],
    ));
  }
}
