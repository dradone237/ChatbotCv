/*
This is the main navigation
In this pages we used WidgetsBindingObserver
This function is used to do something when you switch to another apps and enter the apps again

install plugin in pubspec.yaml
- fluttertoast => to show toast (https://pub.dev/packages/fluttertoast)

Don't forget to add all images and sound used in this pages at the pubspec.yaml
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ijshopflutter/config/constants.dart';
import 'package:ijshopflutter/ui/account/account.dart';
import 'package:ijshopflutter/ui/home/home1.dart';
import 'package:ijshopflutter/ui/reuseable/app_localizations.dart';
import 'package:ijshopflutter/ui/shopping_cart/shopping_cart.dart';
import 'package:ijshopflutter/ui/wishlist/wishlist.dart';

import 'activity/activity.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;

  // Pages if you click bottom navigation
  final List<Widget> _contentPages = <Widget>[
    HomePage(),
    WishlistPage(),
    ActivityPage(),
    ShoppingCartPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    // set initial pages for navigation to home page
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // this function is used for exit the application, user must click back button two times
  DateTime? _currentBackPressTime;
  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!
              .translate('press_back_again_to_exit')!,
          toastLength: Toast.LENGTH_LONG);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: _contentPages.map((Widget content) {
            return content;
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
          _pageController.jumpToPage(value);
          // this unfocus is to prevent show keyboard in the wishlist page when focus on search text field
          FocusScope.of(context).unfocus();
        },
        selectedFontSize: 8,
        unselectedFontSize: 8,
        iconSize: 28,
        selectedLabelStyle: TextStyle(
            color: _currentIndex == 1 ? ASSENT_COLOR : PRIMARY_COLOR,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(color: CHARCOAL, fontWeight: FontWeight.bold),
        selectedItemColor: _currentIndex == 1 ? ASSENT_COLOR : PRIMARY_COLOR,
        unselectedItemColor: CHARCOAL,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home,
                  color: _currentIndex == 0 ? PRIMARY_COLOR : CHARCOAL)),
          BottomNavigationBarItem(
              label: 'Whishlist',
              icon: Icon(Icons.favorite,
                  color: _currentIndex == 1 ? ASSENT_COLOR : CHARCOAL)),
          BottomNavigationBarItem(
              label: 'Activity',
              icon: Icon(Icons.favorite,
                  color: _currentIndex == 2 ? ASSENT_COLOR : CHARCOAL)),
          BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(Icons.shopping_cart,
                  color: _currentIndex == 3 ? PRIMARY_COLOR : CHARCOAL)),
          BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(Icons.person_outline,
                  color: _currentIndex == 4 ? PRIMARY_COLOR : CHARCOAL)),
        ],
      ),
    );
  }
}
