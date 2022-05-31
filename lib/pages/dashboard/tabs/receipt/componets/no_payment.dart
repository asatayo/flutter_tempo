import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:tempo/utils/prefs.dart';

class NoPaymentMade extends StatelessWidget {
  final Function notifyParent;
  const NoPaymentMade({Key? key, required this.notifyParent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            // ignore: deprecated_member_use
            FontAwesomeIcons.sadCry,
            color: Theme.of(context).backgroundColor,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'you_have_no_receipt'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'no_receipt_description'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                        height: 1,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _keepSelected(
                                  true, 5, "Houses", "House");
                              currentIndexPage = 0;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardPage()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'book_house'.tr,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    // ignore: deprecated_member_use
                                    FontAwesomeIcons.home,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                               _keepSelected(
                                  true, 0, "All", "All");
                              currentIndexPage = 0;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardPage()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'other'.tr,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.menu,
                                    color: Colors.black87,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void _keepSelected(bool isHouse, int option, String name, String value) {
    Prefs.storeIntPref('selectedIndexPref', option);
    Prefs.storePref('selectedNamePref', name);
    Prefs.storePref('selectedValuePref', value);
    if (isHouse) {
      Prefs.saveData('isHouse', true);
    } else {
      //  print('Unset to others');
      Prefs.saveData('isHouse', false);
    }
    notifyParent();
  }
}
