import 'package:flutter/material.dart';

import 'package:gartenjeden/components/button.dart';
import 'package:gartenjeden/components/cover_image.dart';
import 'package:gartenjeden/components/intro_headline.dart';
import 'package:gartenjeden/screens/authenticated/tab_navigation.dart';

import 'package:gartenjeden/shared/styles.dart';
import 'package:gartenjeden/shared/utils.dart';

import 'package:gartenjeden/services/auth_service.dart';

import 'authenticated/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoverImage(
        childWidget: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const IntroHeadline(
                headline: "Anmelden", 
                subHeadline: "Deine Pflanzen warten auf dich!"
              ),
              const SizedBox(
                height: 15
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "E-Mail"
                      ),
                      initialValue: email,
                      validator: (value) {
                        if(value!.length < 4) {
                          return "Bitte gib eine gültige E-Mail Adresse ein.";
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }
                    ),
                    const SizedBox(
                      height: 10
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "Password"
                      ),
                      initialValue: password,
                      obscureText: true,
                      validator: (value) {
                        if(value!.length < 8) {
                          return "Bitte gib ein Passwort ein.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      }
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    Button(
                      text: "senden", 
                      action: () async {
                        if(_formKey.currentState!.validate()) {
                          var authorizedUser = await auth.signIn(email, password);
                          
                          if(authorizedUser == false) {
                            showErrorDialog(
                              context, 
                              "Bitte überprüfe deine Anmelde Daten"
                            );
                          } else {
                            resetNavigationAndOpenScreen(context, const TabNavigation());
                          }
                        }
                      }
                    )
                  ]
                )
              ),
            ]
          ),
        )
      )
    );
  }
}