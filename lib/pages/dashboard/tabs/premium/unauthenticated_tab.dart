import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:tempo/pages/signin/sign_in_page.dart';
import 'package:tempo/pages/signup/sign_up.dart';

class UnAuthenticatedTab extends StatefulWidget {
   const UnAuthenticatedTab({Key? key}) : super(key: key);

  @override
  UnAuthenticatedTabState createState() => UnAuthenticatedTabState();
}

class UnAuthenticatedTabState extends State<UnAuthenticatedTab> {
  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Container(
            height: MediaQuery.of(context).size.height-120,
            padding:  
            const EdgeInsets.all(5),
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              FaIcon(
              FontAwesomeIcons.crown, color: Theme.of(context).backgroundColor,
              size: 50,
            ),
             const SizedBox(
              height: 10,
            ),
             Text('premium_user'.tr,
               style: const TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.w700,
               ),),
             const SizedBox(
              height: 10,
            ),
            Card(
              child: Container(
                padding:  const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text(
                          'premium_description'.tr,
                       style: const TextStyle(
                         fontSize: 16,
                       ),),
                         
                       const SizedBox(height: 10,),
                       Divider(height: 1, color: Theme.of(context).textTheme.bodyText1!.color),
                         const SizedBox(height: 10,
                      ),

                       Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  const Signup(shouldAuthenticate: false,))).then((value) => setState((){
                                          
                                        }));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius:  BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                padding:  const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text('sign_up'.tr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                     const SizedBox(width: 10),
                                     const Icon(FontAwesomeIcons.userPlus,
                                        color: Colors.white, size: 18,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                               
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             const Signin(shouldAutheticate: true)));
                              },
                              child: Container(
                                decoration:   BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                padding:  const EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                     Text('sign_in'.tr,
                                       style: const TextStyle(
                                         fontSize: 16,
                                         fontWeight: FontWeight.w700,
                                         color: Colors.black,
                                       ),),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.login,
                                        color: Colors.black87, size: 18, ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                  )
              ),
            ),
            
          ],
        ),
          ),
    );
    
  }
}
