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
    Home(),
    FoldersScreen(),
    Shop(),
    Social(),
    Pay(),
  ];

  @override
  Widget build(BuildContext context) {
    final fabs = [
      FloatingActionButton(
          onPressed: () {}, tooltip: 'Search', child: Icon(Icons.search)),
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
          child: Icon(LucideIcons.plus)),
      FloatingActionButton(
          onPressed: () {},
          tooltip: 'Cart',
          child: Icon(LucideIcons.shopping_cart)),
      FloatingActionButton(
          onPressed: () {},
          tooltip: 'Friends',
          child: Icon(LucideIcons.message_circle)),
      FloatingActionButton(
          onPressed: () {},
          tooltip: 'Scan QR',
          child: Icon(Icons.qr_code_scanner)),
    ];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) =>
              setState(() => currentPageIndex = index),
          destinations: const <Widget>[
            NavigationDestination(icon: Icon(LucideIcons.house), label: 'Home'),
            NavigationDestination(icon: Icon(LucideIcons.box), label: 'Tasks'),
            NavigationDestination(
                icon: Icon(LucideIcons.shopping_bag), label: 'Shop'),
            NavigationDestination(
                icon: Icon(LucideIcons.pyramid), label: 'Social'),
            NavigationDestination(
                icon: Icon(LucideIcons.indian_rupee), label: 'Pay'),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(2, 8, 2, 0),
          child: screens[currentPageIndex],
        ),
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
      ),
    );
  }
}

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Shop'));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Home'));
  }
}

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
            (int index) {
              return ChoiceChip.elevated(
                label: Text(chipList[index]),
                selected: _value == index,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? index : null;
                  });
                },
              );
            },
          ).toList(),
        ),
        Center(child: const Text('Social')),
      ],
    );
  }
}

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Pay'));
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
