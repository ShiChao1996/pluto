import 'package:flutter/material.dart';
import './navigationBar.dart';

class MyContainer extends StatefulWidget {
  @override
  MyContainerState createState() => new MyContainerState();
}

class MyContainerState extends State<MyContainer>
    with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.apps),
        title: const Text('Node'),
        color: Colors.deepPurple,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: const Text('Mine'),
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: const Text('Favorites'),
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.account_circle),
        title: const Text('Me'),
        color: Colors.blueGrey,
        vsync: this,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      body: new Center(
        child: new Text("ddd"),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
