import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gartenjeden/components/button.dart';
import 'package:gartenjeden/components/cover_image.dart';
import 'package:gartenjeden/components/intro_headline.dart';

import 'package:gartenjeden/screens/signin.dart';
import 'package:gartenjeden/screens/signup.dart';

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
                headline: "Garten Jeden", 
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