import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:get/get.dart';
Widget bottomNavigationBar(BuildContext context, bottomNavTapped) {
  return   ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              child: BottomNavigationBar(
                // fixedColor:Theme.of(context).primaryTextTheme.bodyText1.color,
                // selectedIndexPrefItemColor: Theme.of(context).textTheme.bodyText2.color,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                selectedItemColor: Theme.of(context).backgroundColor,
                unselectedItemColor: Colors.grey,
                currentIndex: currentIndexPage,
                onTap: bottomNavTapped,
                items: [
                  BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: const FaIcon(FontAwesomeIcons.home),
                    label: 'home'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const FaIcon(FontAwesomeIcons.crown),
                    label: 'premium'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const FaIcon(FontAwesomeIcons.receipt),
                    label: 'receipt'.tr,
                  ),
                  BottomNavigationBarItem(
                    // ignore: deprecated_member_use
                    icon: const FaIcon(FontAwesomeIcons.infoCircle),
                    label: 'more'.tr,
                  )
                ],
              ),
        
        );


      // : AnimatedContainer(
      //     duration: const Duration(seconds: 0),
      //     height: bottomBarHeight,
      //     child: SingleChildScrollView(
      //         child: Container(
      //       height: bottomBarHeight,
      //       decoration: BoxDecoration(
      //           borderRadius: const BorderRadius.only(
      //             topLeft: Radius.circular(10),
      //             topRight: Radius.circular(10),
      //           ),
      //           boxShadow: [
      //             BoxShadow(
      //                 color: Theme.of(context).backgroundColor,
      //                 spreadRadius: 3,
      //                 blurRadius: 5)
      //           ]),
      //       child: ClipRRect(
      //         borderRadius: const BorderRadius.only(
      //             topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      //         child: BottomNavigationBar(
      //           // fixedColor:Theme.of(context).primaryTextTheme.bodyText1.color,
      //           // selectedIndexPrefItemColor: Theme.of(context).textTheme.bodyText2.color,
      //           type: BottomNavigationBarType.fixed,
      //           elevation: 0,
      //           currentIndex: currentIndexPage,
      //           onTap: bottomNavTapped,
      //           items: [
      //             BottomNavigationBarItem(
      //               // ignore: deprecated_member_use
      //               icon: const FaIcon(FontAwesomeIcons.home),
      //               label: 'home'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: const FaIcon(FontAwesomeIcons.crown),
      //               label: 'premium'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: const FaIcon(FontAwesomeIcons.receipt),
      //               label: 'receipt'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               // ignore: deprecated_member_use
      //               icon: const FaIcon(FontAwesomeIcons.infoCircle),
      //               label: 'more'.tr,
      //             )
      //           ],
      //         ),
      //       ),
      //     )),
      //   );
}
