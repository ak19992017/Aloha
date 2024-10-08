import 'package:aloha/auth/signin.dart';
import 'package:aloha/constant.dart';
import 'package:aloha/tasks/add.dart';
import 'package:aloha/tasks/folders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "./home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final screens = [
    Categories(),
    FoldersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final fabs = [
      FloatingActionButton(
          onPressed: () {},
          tooltip: 'Scan QR',
          child: Icon(Icons.qr_code_scanner)),
      FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFoldersScreen(),
              ),
            );
          },
          tooltip: 'Add task',
          child: Icon(Icons.add)),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Aloha'), centerTitle: true),
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
              FilledButton(
                  onPressed: () async {
                    await supabase.auth.signOut();
                    Navigator.of(context)
                        .popAndPushNamed(SignInScreen.routeName);
                  },
                  child: Text('Log Out')),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close Drawer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // final User? user = supabase.auth.currentUser;
    // String prettyprint = JsonEncoder.withIndent('  ').convert(user);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Carousal(),
          GridView.count(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              CategoryIcon(icon: LucideIcons.shopping_bag, label: 'Shop'),
              CategoryIcon(icon: LucideIcons.indian_rupee, label: 'Pay'),
              CategoryIcon(icon: LucideIcons.pyramid, label: 'Social'),
            ],
          ),
          // Padding(padding: const EdgeInsets.all(8.0), child: Text(prettyprint))
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
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class Carousal extends StatefulWidget {
  const Carousal({super.key});

  @override
  State<Carousal> createState() => _CarousalState();
}

class _CarousalState extends State<Carousal> {
  late PageController _pageController;

  List<String> images = [
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  ];

  int activePage = 0;
  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          child: PageView.builder(
            itemCount: images.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) => setState(() => activePage = page),
            itemBuilder: (context, pagePosition) => Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Image.network(images[pagePosition]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...indicators(images.length, activePage)],
        )
      ],
    );
  }
}
