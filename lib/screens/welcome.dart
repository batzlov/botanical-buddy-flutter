import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:botanicalbuddy/components/button.dart';
import 'package:botanicalbuddy/components/cover_image.dart';
import 'package:botanicalbuddy/components/intro_headline.dart';

import 'package:botanicalbuddy/screens/signin.dart';
import 'package:botanicalbuddy/screens/signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: CoverImage(
        childWidget: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const IntroHeadline(
                headline: "Botanical Buddy", 
                subHeadline: "Dein Zuhause jetzt grüner"
              ),
              const SizedBox(
                height: 25
              ),
              Button(
                text: "Los gehts!", 
                action: () {
                  // navigate to the sign up
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp())
                  );
                }
              ),
              const SizedBox(
                height: 10
              ),
              Button(
                text: "Einloggen", 
                action: () {
                  // navigate to the sign in
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn())
                  );
                }
              )
            ]
          ),
        )
      )
    );
  }
}