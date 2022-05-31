import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget cancelButton(BuildContext context, canceButtunCallBack) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.only(left: 80, right: 80, bottom: 0),
    child: 
    ButtonTheme(
      child: OutlinedButton(
        onPressed: canceButtunCallBack,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0, color: Colors.transparent),
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('cancel'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      const SizedBox(width: 10),
                      const Icon(Icons.cancel_schedule_send_outlined,
                          color: Colors.white, size: 20),
                    ],
                  )
          ),
        ),
      ),

    // InkWell(
    //   onTap: canceButtunCallBack,
    //   child: Container(
    //     decoration: const BoxDecoration(
    //       color: Colors.red,
    //       borderRadius: BorderRadius.all(Radius.circular(50)),
    //     ),
    //     padding:
    //         const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    //     height: 50,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text('cancel'.tr,
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 15,
    //             )),
    //         const SizedBox(width: 10),
    //         const Icon(Icons.cancel_schedule_send_outlined,
    //             color: Colors.white, size: 20),
    //       ],
    //     ),
    //   ),
    // ),
  );
}
