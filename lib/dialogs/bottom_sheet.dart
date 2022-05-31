
import 'package:flutter/material.dart';
import 'package:tempo/constants/constants.dart';

class BottomDialogView {
  final String title;
  final IconData icon;
  BottomDialogView( {required this.title, required this.icon}); 
  showBottomDialog(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          child: Wrap(
            children: <Widget>[
              Center(
                  child: Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    heightSpace,
                    heightSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  <Widget>[
                        Icon(icon, size:  50,),
                        widthSpace,
                        widthSpace,
                      ],
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Text(
                      title,
                      textAlign: TextAlign.justify,
                      style: black15SemiBoldTextStyle,
                    ),
                    const SizedBox(height: 20,),
                     InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                        },
                        child:  Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(fixPadding * 1.2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              'OK',
                              style: black18BoldTextStyle,
                            ),
                        
                        )
                        ),
                         const SizedBox(height: 20,),
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}