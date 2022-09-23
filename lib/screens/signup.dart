import 'package:flutter/material.dart';

import 'package:gartenjeden/screens/authenticated/home.dart';

import 'package:gartenjeden/components/button.dart';
import 'package:gartenjeden/components/cover_image.dart';
import 'package:gartenjeden/components/intro_headline.dart';

import 'package:gartenjeden/shared/utils.dart';
import 'package:gartenjeden/shared/styles.dart';

import 'package:gartenjeden/services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();

  String firstName = "";
  String lastName = "";
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
                headline: "Registrieren", 
                subHeadline: "Worauf wartest du noch?"
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
                        hintText: "Vorname"
                      ),
                      validator: (value) {
                        if(value!.length < 2) {
                          return "Bitte gib einen gültigen Namen ein.";
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      }
                    ),
                    const SizedBox(
                      height: 10
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "Nachname"
                      ),
                      validator: (value) {
                        if(value!.length < 2) {
                          return "Bitte gib einen gültigen Namen ein.";
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      }
                    ),
                    const SizedBox(
                      height: 10
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "E-Mail"
                      ),
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
                      obscureText: true,
                      validator: (value) {
                        if(value!.length < 4) {
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
                          var createdUser = await auth.signUp(firstName, lastName, email, password);
                          if(createdUser == false) {
                            showErrorDialog(
                              context, 
                              "Deine Registrierung war nicht erfolgreich."
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home())
                            );
                          }
                        }
                      },
                    )
                  ]
                )
              )
            ]
          ),
        )
      )
    );
  }
}