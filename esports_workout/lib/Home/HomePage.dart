import 'package:esports_workout/Games/GamesPage.dart';
import 'package:flutter/material.dart';
import 'TrainingPage.dart';
import 'Profile.dart';
import 'Trends.dart';

class Homepage extends StatefulWidget {
  static const String routename = 'Homepage';

  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onDrawerItemTapped(int index) {
    if (index == 3) {
      Navigator.pop(context); // Cierra el drawer antes de navegar
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GamesPage()),
      );
    } else {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(index);
      });
      Navigator.pop(context); // Close the drawer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color del ícono del Drawer a blanco
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Esport Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white, // Cambia el color del Drawer a blanco
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(248, 38, 12, 56),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search, color: Colors.black),
              title: const Text('Trends'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.videogame_asset, color: Colors.black),
              title: const Text('Entrenamiento'),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: const Text('Perfil'),
              onTap: () => _onDrawerItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Colors.black),
              title: const Text('Ver Juegos'),
              onTap: () => _onDrawerItemTapped(3),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          Trends(),
          TrainingPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        backgroundColor: const Color.fromARGB(248, 38, 12, 56),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
