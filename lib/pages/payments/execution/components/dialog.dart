import 'package:flutter/material.dart';
import 'package:get/get.dart';
confirmDialog(BuildContext context, yesCallBackFun, noCallBackFun) {
  showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) => SimpleDialog(
              insetPadding: const EdgeInsets.all(30),
              backgroundColor: Theme.of(context).cardColor,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'confirm_operation'.tr,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'are_you_sure_you_want_to_cancel'.tr,
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.5),
                                ),
                              ])),
                              const Divider(),
                      Container(
                        // height: 60,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              ButtonTheme(
                                      child: OutlinedButton(
                                        
                                         onPressed: noCallBackFun,
  
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(width: 0, color: Colors.transparent),
                                      backgroundColor: Colors.transparent,
                                    
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                  ),
                                  child:  Center(child: Text('no'.tr,
                                                style:  const TextStyle(
                                                    
                                                    fontSize: 16)),
                                        
                                        ),
                                ),
                              
                            ),
                                    
                             const SizedBox(width: 30),
                             ButtonTheme(
                                      child: OutlinedButton(
                                        
                                         onPressed: yesCallBackFun,
  
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(width: 0, color: Colors.transparent),
                                      backgroundColor: Colors.transparent,
                                    
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                  ),
                                  child:  Center(child: Text('yes'.tr,
                                                style:  const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16)),
                                        
                                        ),
                                ),
                              
                            )
                          ],
                        ),
                      )
                    ])
              ]));
}
