import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/block/base/bloc_provider.dart';
import 'package:flutter_app/block/home_block.dart';
import 'package:flutter_app/block/model/user.dart';
import 'package:flutter_app/ui/home/screens/calendar_screen.dart';
import 'package:flutter_app/ui/home/screens/coach_screen.dart';
import 'package:flutter_app/ui/home/screens/reward_screen.dart';

import 'screens/main_page_screen.dart';

class Home extends StatefulWidget {
  final UserLogin userLogin;
  final String restorationId = "0";

  Home(this.userLogin, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationDemoState(userLogin);
}

enum HomeScreens { Main, Coach, Calendar, Reward }

class _BottomNavigationDemoState extends State<Home> with RestorationMixin {
  final RestorableInt _currentIndex = RestorableInt(0);
  final UserLogin userLogin;

  _BottomNavigationDemoState(this.userLogin);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: "Main Page",
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.message_rounded),
        label: "Virtual Coach",
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.calendar_today),
        label: "Calendar",
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.card_giftcard),
        label: "Reward",
      ),
    ];
  }

  Widget _getNavigationView(int viewItem) {
    final HomeBlock homeBloc = HomeBlock(userLogin);

    Widget block;
    // Adding [UniqueKey] to make sure the widget rebuilds when transitioning.
    switch (HomeScreens.values[viewItem]) {
      case HomeScreens.Main:
        block = BlocProvider(
            key: UniqueKey(), child: MainPageScreen(), bloc: homeBloc);
        break;
      case HomeScreens.Coach:
        block = BlocProvider(
            key: UniqueKey(), child: CoachScreen(), bloc: homeBloc);
        break;
      case HomeScreens.Calendar:
        block = BlocProvider(
            key: UniqueKey(), child: CalendarScreen(), bloc: homeBloc);
        break;
      case HomeScreens.Reward:
        block = BlocProvider(
            key: UniqueKey(), child: RewardScreen(), bloc: homeBloc);
        break;
    }
    return block;
  }

  Widget _getContentOfPage() {
    return Scaffold(
      body: Column(
        children: <Widget>[
            Expanded(
            child: Center(
              child: PageTransitionSwitcher(
                child: _getNavigationView(_currentIndex.value),
                transitionBuilder: (child, animation, secondaryAnimation) {
                  return FadeThroughTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                  );
                },
              ),
            ),
          ),
            SizedBox(
              width: double.infinity,
              height: 1,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.blue),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = _getBottomNavigationItems();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(bottomNavigationBarItems[_currentIndex.value].label),
      ),
      body: _getContentOfPage(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textTheme.caption.fontSize,
        unselectedFontSize: textTheme.caption.fontSize,
        onTap: (index) {
          setState(() {
            _currentIndex.value = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue.withOpacity(0.38),
      ),
    );
  }
}
