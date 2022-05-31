import 'package:tempo/pages/settings/setttings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/widgets/satefull/logout.dart';

class InfoTab extends StatefulWidget {
   const InfoTab({Key? key}) : super(key: key);

  @override
  InfoTabState createState() => InfoTabState();
}

class InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: MediaQuery.of(context).size.height - 100,
        padding:  const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:  const BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset:  const Offset(4, 5), // Shadow
                      color: Theme.of(context).backgroundColor,
                    )
                  ]),
              child: ClipRRect(
                borderRadius:  const BorderRadius.all(Radius.circular(100)),
                child: Center(
                  child: FaIcon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.userCircle,
                    color: Theme.of(context).iconTheme.color,
                    size: 80,
                  ),
                ),
              ),
            ),
             const SizedBox(
              height: 10,
            ),
            Text('online_tempo_tempo'.tr),
             
             const SizedBox(
              height: 10,
            ),
            _logOut(context),
            _aboutUs(context),
            _contactUs(context),
            _aboutPrivacy(context),
            _aboutDeveloper(context),
            _settings(context),
            // _aboutUs(context),
            // _aboutUs(context),
          ],
        ),
      ),
    );
  }

   Widget _aboutUs(BuildContext context) {
    return GestureDetector(
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use
                FaIcon(FontAwesomeIcons.infoCircle,
                    size: 20,
                    color: Theme.of(context).textTheme.bodyText2!.color),
                const SizedBox(width: 10),
                Text(
                  'about_us'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _logOut(BuildContext context) {
    return GestureDetector(
        onTap: (){
           showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (_) => const LogoutDialog());
          
        },
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Container(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 FaIcon(
                  // ignore: deprecated_member_use
                  FontAwesomeIcons.signOutAlt,
                  size: 20, color: Theme.of(context).textTheme.bodyText2!.color
                ),
                 const SizedBox(width: 10),
                Text('logout'.tr,  style: const TextStyle(
                  fontSize: 20,
                ),),
              ],
            )),
      ),
    );
  }

  Widget _contactUs(BuildContext context) {
    return GestureDetector(
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all( Radius.circular(20))),
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 FaIcon(
                  FontAwesomeIcons.phone,
                 size: 20,
                    color: Theme.of(context).textTheme.bodyText2!.color
                ),
                 const SizedBox(width: 10),
                Text('contact_us'.tr,  style: const TextStyle(
                  fontSize: 20,
                ),),
              ],
            )),
      ),
    );
  }

  Widget _aboutPrivacy(BuildContext context) {
    return GestureDetector(
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape:  const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 FaIcon(
                  FontAwesomeIcons.fileContract,
                  size: 20, color: Theme.of(context).textTheme.bodyText2!.color
                ),
                 const SizedBox(width: 10),
                Text('privacy_policy'.tr,
                  style: const TextStyle(
                  fontSize: 20,
                ),),
              ],
            )),
      ),
    );
  }

  Widget _aboutDeveloper(BuildContext context) {
    return GestureDetector(
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 FaIcon(
                  FontAwesomeIcons.code,
                  size: 20,
                    color: Theme.of(context).textTheme.bodyText2!.color
                ),
                 const SizedBox(width: 10),
                Text('about_developer'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                  ),),
              ],
            )),
      ),
    );
  }

  Widget _settings(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>   const SettingsPage()));
      },
      child: Card(
        borderOnForeground: true,
        elevation: 3,
        shadowColor: Theme.of(context).backgroundColor,
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
            padding:  const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 FaIcon(
                  // ignore: deprecated_member_use
                  FontAwesomeIcons.cogs,
                  size: 20,
                    color: Theme.of(context).textTheme.bodyText2!.color
                ),
                 const SizedBox(width: 10),
                Text('settings'.tr,  style: const TextStyle(
    
                  fontSize: 20,
                ),),
              ],
            )),
      ),
    );
  }
}
