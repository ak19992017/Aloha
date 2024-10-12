import 'package:flutter/material.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  int? _value = 0;
  List<String> chipList = ['Feed', 'News', 'Jobs'];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5.0,
          children: List<Widget>.generate(
            3,
            (int index) => ChoiceChip.elevated(
              label: Text(chipList[index]),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                });
              },
            ),
          ).toList(),
        ),
        Center(child: const Text('Social')),
      ],
    );
  }
}
