import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final screens = [
    Categories(),
    Tasks(),
  ];

  final fabs = [
    FloatingActionButton(
        onPressed: () {},
        tooltip: 'Scan QR',
        child: Icon(Icons.qr_code_scanner)),
    FloatingActionButton(
        onPressed: () {}, tooltip: 'Add task', child: Icon(Icons.add)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aloha'), centerTitle: true, elevation: 10),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) =>
            setState(() => currentPageIndex = index),
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(LucideIcons.house), label: 'Home'),
          NavigationDestination(icon: Icon(LucideIcons.box), label: 'Tasks'),
        ],
      ),
      body: screens[currentPageIndex],
      floatingActionButton: fabs[currentPageIndex],
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FilledButton(onPressed: () {}, child: Text('LogOut')),
              FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close Drawer')),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imagePath;
  const ImageDetailPage(this.imagePath, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image')),
      body: Center(
        child: Hero(
          tag: 'image${imagePath.hashCode}',
          child: Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  static const entries = [
    {"id": 1, "title": "Brushing teeth twice a day", "image": "brush.jpg"},
    {"id": 2, "title": "Taking a bath every day", "image": "bath.jpg"},
    {"id": 3, "title": "Eating a healthy breakfast", "image": "eat.jpg"},
    {"id": 4, "title": "Drinking water frequently", "image": "water.jpg"},
    {"id": 5, "title": "Getting physical activity", "image": "exercise.jpg"},
    {"id": 6, "title": "Reading every day", "image": "read.jpg"},
    {
      "id": 7,
      "title": "Spending time with family and friends",
      "image": "family.jpg"
    },
    {"id": 8, "title": "Respect elders", "image": "elder.jpg"},
    {"id": 9, "title": "Help others", "image": "help.jpg"},
    {"id": 10, "title": "Avoid procrastination", "image": "time.jpg"},
  ];
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Card(
            child: ListTile(
              title: Row(
                children: [
                  Text({index + 1}.toString()),
                  Text(
                    ' ${entries[index]['title']}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageDetailPage("assets/${entries[index]['image']}"),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 3,
        children: <Widget>[
          CategoryIcon(icon: LucideIcons.shopping_bag, label: 'Shop'),
          CategoryIcon(icon: LucideIcons.indian_rupee, label: 'Pay'),
          CategoryIcon(icon: LucideIcons.pyramid, label: 'Social'),
        ],
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const CategoryIcon({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
