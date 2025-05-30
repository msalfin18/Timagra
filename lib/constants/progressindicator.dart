 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timagra_new/constants/constants.dart';


class CircularProgressIndicatorconst extends StatelessWidget {
  const CircularProgressIndicatorconst({super.key});

  @override
  Widget build(BuildContext context) {
    return 
 
 Center(child: Theme.of(context).platform ==
                                          TargetPlatform.iOS
                                      ? CupertinoActivityIndicator(
                                        color: greycolor
                                      )
                                      : CircularProgressIndicator(
                                        color:  greycolor
                                      ),);

  }}