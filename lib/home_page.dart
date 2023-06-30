import 'package:auto_route/auto_route.dart';
import 'package:e_commerce/Home/FeedPage.dart';
import 'package:e_commerce/Home/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// class Home_Route extends StatelessWidget {
//   const Home_Route({super.key});

//   const Home_Route({super.key});

//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => const Home_Route());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Home();
//   }
// }
@RoutePage()
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

PageController pageController = PageController();

class _HomeState extends State<Home> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void pageChanged(int index) {
    setState(() {
      _selectIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: const [
          Homepage(),
          FeedPage(),
          Placeholder(),
          Placeholder(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(158, 158, 158, 0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 20.0,
          color: Colors.white,
          child: BottomNavigationBar(
            onTap: onTapped,
            selectedItemColor: const Color.fromRGBO(255, 64, 129, 1),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.shopify), label: 'Mall'),
              BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Says'),
            ],
          ),
        ),
      ),
    );
  }
}
