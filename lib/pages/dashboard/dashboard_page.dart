import 'dart:async';
//245768
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tempo/builders/authentication_builder.dart';
import 'package:tempo/is_waiting.dart';
import 'package:tempo/pages/dashboard/tabs/menu_tab.dart';
import 'package:tempo/pages/dashboard/bottom_nav_bar.dart';
import 'package:tempo/pages/dashboard/notification_language.dart';
import 'package:tempo/pages/dashboard/tabs/premium/authenticated_tab.dart';
import 'package:tempo/pages/dashboard/tabs/receipt/receipt_tab.dart';
import 'package:tempo/pages/dashboard/tabs/premium/unauthenticated_tab.dart';
import 'package:tempo/pages/dashboard/tabs/info_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


int currentIndexPage = 0;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  DashboardPageState createState() => DashboardPageState();
}

ScrollController _listScrollController =
    ScrollController(); // set controller on scrolling
bool isScrollingDown = false;
// bool showBottomBar = true;
bool isEnglish = true;
double bottomBarHeight = 70;
double appBarHeight = 220;
// set bottom bar height
Color? headerColor; // set bottom bar height

class DashboardPageState extends State<DashboardPage> {
  int notificationCounter = 0;

  @override
  void initState() {
    super.initState();
    _listenFromFirebase(context);
    ReceiptCheck.initCheck(context);
    _listScrollController = ScrollController();
    _listScrollController.addListener(_scrollControllerListener);
    // myScroll();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void _listenFromFirebase(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    //  print(event.data['title']);
    //  print('Something new was actually received from notification');
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _scrollControllerListener() {
    // print('Bottom');
    if (_listScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      isScrollingDown = true;
      if (isScrollingDown) {
        isScrollingDown = false;
        setState(() {
          // showBottomBar = false;
          bottomBarHeight = 0;
          appBarHeight = 220;
        });
      }
    }

    if (_listScrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      isScrollingDown = false;
      if (!isScrollingDown) {
        isScrollingDown = true;
        setState(() {
          // showBottomBar = true;
          bottomBarHeight = 70;
          appBarHeight = 0;
        });
      }
    }
  }

  @override
  void dispose() {
    _listScrollController.removeListener(_scrollControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    headerColor = Theme.of(context).backgroundColor;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          elevation: 0,
          actions: [
            language(context),
            notification(context),
          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                Image.asset('assets/images/logo.png', height: 50)
              ]),
        ),
        bottomNavigationBar: bottomNavigationBar(context, bottomNavTapped),
        body: IndexedStack(
          index: currentIndexPage,
          children: [
            SingleChildScrollView(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _listScrollController,
                child: MenuTab(notifyParent: notifyParent)),
            FutureBuilder<bool>(
              builder: (context, data) {
                if (data.hasData) {
                  bool? isAuthenticatedUser = data.data;
                  if (isAuthenticatedUser!) {
                    return ListView(
                      shrinkWrap: true,
                      children: [PremiumTab(notifyParent: notifyParent)],
                    );
                  } else {
                    return const UnAuthenticatedTab();
                  }
                } else {
                  return const UnAuthenticatedTab();
                }
              },
              future: isAuthenticated(),
            ),
            ReceiptTabView(notifyParent: notifyParent),
            ListView(
              shrinkWrap: true,
              children: const [InfoTab()],
            ),
          ],
        ),
      ),
    );
  }

  void notifyParent() {
    setState(() {});
  }

  void bottomNavTapped(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }
}
