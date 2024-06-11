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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
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
        backgroundColor: const Color.fromARGB(
            248, 38, 12, 56), // Color de fondo de la barra de navegación
        selectedItemColor:
            Colors.white, // Color de los íconos y etiquetas seleccionados
        unselectedItemColor: Colors.white.withOpacity(
            0.5), // Color de los íconos y etiquetas no seleccionados
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
