import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
   const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
                  color: Theme.of(context).cardTheme.color,
                  shape:  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Column(
                    children: [
                      Container(
                        decoration:  const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15))),
                        height: MediaQuery.of(context).size.width / 2.8,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius:  const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                              child:Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColor,
                                highlightColor:  const Color(0xFFC6C8C9),
                                child: Container(
                            color: Theme.of(context).backgroundColor,
                            height: MediaQuery.of(context).size.width/6,
                            
                          )),
                          ),
                        ),
                
                       const SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding:  const EdgeInsets.only(
                            left: 0, right: 0, top: 5, bottom: 5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).primaryColor,
                                highlightColor: Colors.grey,
                                child: Container(
                                height: 10,
                                decoration: BoxDecoration(
                                          color:Theme.of(context).backgroundColor,
                                          borderRadius:  const BorderRadius.all(Radius.circular(20)),
                                        ),
                                width: MediaQuery.of(context).size.width / 3,
                               )
                               ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer__literals_to_create_immutables
                                children: [
                                   Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.amber,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                      borderRadius:  const BorderRadius.all(
                                           Radius.circular(20)),
                                    ),
                                    height: 10,
                                    width: 10,
                                  )),
                                   Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    decoration: BoxDecoration(
                                          color:Theme.of(context).backgroundColor,
                                          borderRadius:  const BorderRadius.all(Radius.circular(20)),
                                        ),
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                  )),
                                ],
                              ),
                            ]),
                      ),
                       const SizedBox(
                        height: 1,
                      ),
                      Container(
                        padding:  const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // ignore: prefer__literals_to_create_immutables
                                    children: [
                                       Shimmer.fromColors(
                                      baseColor: Theme.of(context).primaryColor,
                                      highlightColor: Colors.amber,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:Theme.of(context).backgroundColor,
                                          borderRadius:  const BorderRadius.all(Radius.circular(20)),
                                        ),
                                        height: 10,
                                        width:10,
                                      )
                                      ),
                                       const SizedBox(width: 5),
                                       Shimmer.fromColors(
                                      baseColor: Theme.of(context).primaryColor,
                                      highlightColor: Colors.grey,
                                      child: Container(
                                        height: 10,
                                         decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius:  const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                      )
                                      ),
                                    ],
                                  )),
                            ]),
                      ),
                    ],
                  ),                
              );
  }
}

