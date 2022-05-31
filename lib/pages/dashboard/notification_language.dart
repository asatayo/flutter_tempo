import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/builders/language_builder.dart';
import 'package:tempo/widgets/satefull/language_dialog_widget.dart';

Widget notification(BuildContext context) {
  return Container(
    height: 50,
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    child: SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        children: [
          Positioned(
              child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
            iconSize: 30,
          )),
          Positioned(
              left: 24,
              top: 7,
              child: Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ))),
          const Positioned(
              left: 29,
              top: 8,
              child:
                  Text('3', style: TextStyle(fontSize: 8, color: Colors.white)))
        ],
      ),
    ),
  );
}

Widget language(BuildContext context) {
  return Container(
    height: 50,
    padding: const EdgeInsets.only(left: 10, right: 0, top: 5, bottom: 5),
    child: SizedBox(
      height: 50,
      width: 60,
      child: Stack(
        children: [
          Positioned(
              child: IconButton(
            onPressed: () {
              showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (_) => const LanguageAlertDialog());
            },
            icon: FaIcon(
              FontAwesomeIcons.language,
              color: Theme.of(context).iconTheme.color,
            ),
            iconSize: 40,
          )),
          Positioned(
              left: 35,
              top: 8,
              child: Container(
                  height: 18,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                  ))),
          Positioned(
              left: 42,
              top: 12,
              child: FutureBuilder(
                builder: (context, data) {
                  if (data.hasData) {
                    bool isEnglish = true;
                    isEnglish = data.data as bool;
                    return isEnglish
                        ? const Text('EN',
                            style: TextStyle(fontSize: 8, color: Colors.black))
                        : const Text('SW',
                            style: TextStyle(fontSize: 8, color: Colors.black));
                  } else {
                    return const Text('EN',
                        style: TextStyle(fontSize: 8, color: Colors.black));
                  }
                },
                future: loadLanguageBool(),
              ))
        ],
      ),
    ),
  );
}
