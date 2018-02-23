import 'package:flutter/material.dart';
import './navigationBar.dart';
import './bodyCard.dart';
import '../pages/home.dart';

class MyContainer extends StatefulWidget {
  @override
  MyContainerState createState() => new MyContainerState();
}

class MyContainerState extends State<MyContainer>
    with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;
  List<BodyCard> _contents;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    print("container update");
    Home homePage = new Home();

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

    _contents = <BodyCard>[
      new BodyCard(
        child: homePage,
        vsync: this,
      ),
      new BodyCard(
        child: const Icon(Icons.backup),
        vsync: this,
      ),
      new BodyCard(
        child: const Icon(Icons.close),
        vsync: this,
      ),
      new BodyCard(
        child: const Icon(Icons.account_circle),
        vsync: this,
      )
    ];

    _contents[_currentIndex].controller.value = 1.0;
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

     for (BodyCard view in _contents)
      transitions.add(view.transition(context));
    /*for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(context));*/

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.listenable;
      final Animation<double> bAnimation = b.listenable;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
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
          _contents[_currentIndex].controller.reverse();
          _currentIndex = index;
          _contents[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      body: new Center(
          child: _buildTransitionsStack()
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
