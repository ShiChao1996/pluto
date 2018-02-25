/*
 * MIT License
 *
 * Copyright (c)  ShiChao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*
 * Revision History:
 *     Initial: 2018/02/24        ShiChao
 */

import 'package:flutter/material.dart';
import './navigationBar.dart';
import './bodyCard.dart';
import '../pages/home.dart';
import '../pages/myBlogPage.dart';
import '../model/node.dart';
import '../model/myArticle.dart';

class MyContainer extends StatefulWidget {
  @override
  MyContainerState createState() => new MyContainerState();
}

class MyContainerState extends State<MyContainer>
    with TickerProviderStateMixin {
  List<NavigationIconView> _navigationViews;
  List<BodyCard> _contents;
  List<NodeArticle> nodeList = [];
  List<MyListInfo> myArtList = [];
  int _currentIndex = 0;
  Widget stack;

  @override
  void initState() {
    super.initState();
    print("container initstate");
    Home homePage = new Home(nodeList, this.setNodeList, this.addNodeList);
    MyBlogPage myBlog = new MyBlogPage(
        myArtList, this.setMyList, this.addMyList);

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
        child: myBlog,
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

  void setNodeList(list) {
    this.setState(() {
      nodeList = list;
      _contents[0] = new BodyCard(
          child: new Home(
              nodeList, (list) => this.setNodeList(list), this.addNodeList),
          vsync: this
      );
    });
  }

  void addNodeList(List<NodeArticle> list) {
    this.setState(() {
      nodeList.addAll(list);
    });
  }

  void setMyList(List<MyListInfo> list) {
    this.setState(() {
      myArtList = list;
    });
    _contents[1] = new BodyCard(
        child: new MyBlogPage(
            myArtList, this.setMyList, this.addMyList),
        vsync: this
    );
  }

  void addMyList(List<MyListInfo> list) {
    this.setState(() {
      myArtList.addAll(list);
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (BodyCard view in _contents)
      transitions.add(view.transition(context));

    // We want to have the newly animating (fading in) views on top.
    /*transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.listenable;
      final Animation<double> bAnimation = b.listenable;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });*/

    return new Stack(children: transitions);
  }

  Widget getPage(int index) {
    /*if(index == _currentIndex){
      return ;
    }*/
    return _contents[index].child;
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
        if (index == _currentIndex) {
          return;
        }
        setState(() {
          _contents[_currentIndex].controller.reverse();
          _currentIndex = index;
          _contents[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      body: getPage(_currentIndex),
      bottomNavigationBar: botNavBar,
    );
  }
}
