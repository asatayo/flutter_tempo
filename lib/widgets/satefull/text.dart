import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

titleText(String title, BuildContext context) {
  return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width * 0.1,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).textTheme.bodyText2!.color,
              )),
          Text(
            title.tr,
            style: const TextStyle(fontSize: 15),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.1,
              child: Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).textTheme.bodyText2!.color,
              )),
        ],
      ));
}

titleSPText(String title, BuildContext context, Color color) {
  return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width * 0.1,
              child: Divider(
                height: 1,
                thickness: 1,
                color: color,
              )),
          Text(
            title.tr,
            style: TextStyle(color: color),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.1,
              child: Divider(
                height: 1,
                thickness: 1,
                color: color,
              )),
        ],
      ));
}
