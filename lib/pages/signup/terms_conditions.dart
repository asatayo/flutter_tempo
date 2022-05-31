import 'package:tempo/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TermsConditionsPage extends StatefulWidget {
   const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  TermsConditionsPageState createState() => TermsConditionsPageState();
}

class TermsConditionsPageState extends State<TermsConditionsPage> {
  late ScrollController _scrollController;
  late Color appbarColor;

  @override
  void initState() {
    //  appbarColor = Theme.of(context).textTheme.bodyText1.color!;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.hasClients && _scrollController.offset > 120) {
      setState(() {
        appbarColor = Theme.of(context).iconTheme.color!;
      });
    } else {
      setState(() {
        appbarColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    appbarColor = Theme.of(context).iconTheme.color!;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.home,
                          color: appbarColor),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text('terms_conditions',
                        style: TextStyle(color: appbarColor)),
                    backgroundColor: Theme.of(context).primaryColor,
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                            child: SizedBox(
                                height: 220,
                                child: FlexibleSpaceBar(
                                    background: Image.asset(
                                  'assets/images/icons/background.jpg',
                                  fit: BoxFit.cover,
                                )))),
                        Positioned(
                            top: 160,
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:  const BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    topRight: Radius.circular(100),
                                  ),
                                ),
                                child:  const ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100)),
                                  child: SizedBox(
                                    height: 40,
                                  ),
                                )))
                      ],
                    ),
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      child: Column(
                        children: [
                          _termsConditions(),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: true,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              padding:  const EdgeInsets.only(
                                  left: 30, right: 30, bottom: 10, top: 30),
                              child: _homePageButton())))
                ],
              ),
            )));
  }

  Widget _homePageButton() {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndexPage = 1;
          Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>  const DashboardPage()))
              .then((value) => setState(() {}));
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding:  const EdgeInsets.all(1),
            decoration:  const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('finish'.tr,
                    style:  const TextStyle(color: Colors.black, fontSize: 20)),
                 const SizedBox(width: 10),
                 const FaIcon(
                  FontAwesomeIcons.check,
                  color: Colors.black,
                  size: 18,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _termsConditions() {
    return Container(
      padding:  const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const SizedBox(
            height: 10,
          ),
          Text('terms_conditions_title'.tr,
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).textTheme.bodyText2!.color)),
           const SizedBox(height: 10),
           const SizedBox(
            height: 20,
          ),
          Text('terms_conditions'.tr, style:  const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
